module Callahan

  module Inquiry

    def self.included(base)
      base.send :extend, ClassMethods
    end  
  
    module ClassMethods

      @@inquirables = []

      def acts_as_inquirable(options = {})  
        has_many :sent_inquries, 
                 :class_name  => "Inquiry", 
                 :foreign_key => "inquirer_id"

        has_many :received_inquries,
                 :class_name  => "Inquiry",
                 :foreign_key => "inquiree_id"

        @@inquirables << self.class

        self.cattr_accessor :inquiry_actions
        self.inquiry_actions = options[:actions]
        
        include Callahan::Inquiry::InquirableInstanceMethods
      end  
  
      def acts_as_inquiry_item(options = {})
        has_many :inquiries,
                 :class_name  => "Inquiry",
                 :foreign_key => "inquiry_item_id"

        self.cattr_accessor :inquiry_actions
        self.inquiry_actions = options[:actions]
        

        options[:actions].each do |action|
          define_method("accept_#{action.to_s}")  { raise NotImplementedError }
          define_method("decline_#{action.to_s}") { raise NotImplementedError }


          @@inquirables.each do |inquirable_class|
            inquirable_class.send(:define_method, "#{self.class.to_s}_#{action.to_s}_requests")          { requests(action) }
            inquirable_class.send(:define_method, "pending_#{self.class.to_s}_#{action.to_s}_requests")  { pending_requests(action) }
            inquirable_class.send(:define_method, "pending_#{self.class.to_s}_#{action.to_s}_requests?") { pending_requests?(action) }

            inquirable_class.send(:define_method, "#{self.class.to_s}_#{action.to_s}_invitations")          { invitations(action) }
            inquirable_class.send(:define_method, "pending_#{self.class.to_s}_#{action.to_s}_invitations")  { pending_invitations(action) }
            inquirable_class.send(:define_method, "pending_#{self.class.to_s}_#{action.to_s}_invitations?") { pending_invitations?(action) }
          end
        end
      end

    end

    module InquirableInstanceMethods

      def options_select(options)
        unless options[:action].nil?
          i.action == options[:action]
        else 
          unless options[:actions].nil?
            options[:actions].include?(i.action)
          else
            true
          end
        end
      end

      def requests(options = {})
        sent_inquries.select { |i| options_select(options) }
      end

      def pending_requests(options = {})
        sent_inquries.select { |i| i.state == "pending" and options_select(options) }
      end

      def pending_requests?
        not pending_requests.empty?
      end


      def invitations(options = {})
        received_inquries.select { |i| options_select(options) }
      end
      
      def pending_invitations(options = {})
        received_inquries.select { |i| i.state == "pending" and options_select(options) }
      end

      def pending_invitations?
        not pending_invitations.empty?
      end


    end
  end



  module InquiriesHelper
    def inquiry_actions(_inquiry_item, _inquiree=nil)
      content_tag :div, :class => "inquiry_actions" do
        content_tag :ul, :class => "inquiry_actions_list" do  
          _inquiry_item.inquiry_actions.collect do |action|  
            content_tag :li, :class => "inquiry_actions_list_item" do
              link_to "Request #{action}", 
                      inquiries_path(:inquirer_id       => current_user.id,
                                     :inquiree_type     => current_user.class.to_s,
                                     :inquiree_id       => _inquiree.nil? ? _inquiry_item            : _inquiree, 
                                     :inquiree_type     => _inquiree.nil? ? _inquiry_item.class.to_s : _inquiree.class.to_s, 
                                     :inquiry_item_id   => _inquiry_item, 
                                     :inquiry_item_type => _inquiry_item.class.to_s, 
                                     :inquiry_type      => action), 
                      :method => :post
            end
          end
        end
      end
    end
  end

end

ActiveRecord::Base.send :include, Callahan::Inquiry
ActionView::Base.send :include, Callahan::InquiriesHelper
