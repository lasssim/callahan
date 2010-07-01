class Inquiry < ActiveRecord::Base
  belongs_to :inquirer,     :polymorphic => true 
  belongs_to :inquiree,     :polymorphic => true 
  belongs_to :inquiry_item, :polymorphic => true

  def accept
    inquiry_item.send(:"accept_#{inquiry_type}", self)
    # TODO: set state of inquiry
    save 
  end

  def decline
    inquiry_item.send(:"decline_#{inquiry_type}", self)
    # TODO: set state of inquiry
    save
  end
end


class Inquirable
end

class InquiryItem
end

