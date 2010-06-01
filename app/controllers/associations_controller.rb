class AssociationsController < ApplicationController
  navigation :clubsteamsplayers_teams

  # GET /associations
  # GET /associations.xml
  def index
    @associations = Association.all

    wfdf = Association.root

    @map = GMap.new("map_div")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init(wfdf.coords, 3)

#    bb = GBounds.new(Association.all.collect { |a| a.coords })
#    @map.center_zoom_on_bounds_init(bb)

    add_assoc_to_map(wfdf)

    Association.root.children.each do |assoc|
      add_assoc_to_map(assoc, "#0000ff")
      assoc.children.each do |club|
        add_assoc_to_map(club, "#ff0000")
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @associations }
    end
  end

  # GET /associations/1
  # GET /associations/1.xml
  def show
    @association = Association.find(params[:id])

    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init(@association.coords, 6)
    @map.overlay_init(GMarker.new(@association.coords))


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @association }
    end
  end

  # GET /associations/new
  # GET /associations/new.xml
  def new
    @association = Association.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @association }
    end
  end

  # GET /associations/1/edit
  def edit
    @association = Association.find(params[:id])
  end

  # POST /associations
  # POST /associations.xml
  def create
    @association = Association.new(params[:association])

    respond_to do |format|
      if @association.save
        flash[:notice] = 'Association was successfully created.'
        format.html { redirect_to(@association) }
        format.xml  { render :xml => @association, :status => :created, :location => @association }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /associations/1
  # PUT /associations/1.xml
  def update
    @association = Association.find(params[:id])

    respond_to do |format|
      if @association.update_attributes(params[:association])
        flash[:notice] = 'Association was successfully updated.'
        format.html { redirect_to(@association) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /associations/1
  # DELETE /associations/1.xml
  def destroy
    @association = Association.find(params[:id])
    @association.destroy

    respond_to do |format|
      format.html { redirect_to(associations_url) }
      format.xml  { head :ok }
    end
  end

  private
  def add_assoc_to_map(_assoc, _color="#0000ff")
    cg = Geokit::Geocoders::GoogleGeocoder.do_reverse_geocode(_assoc.coords).country_code
    unless cg.nil?
      cg.downcase!
      @map.icon_global_init(
        GIcon.new(:image              => "/images/flags/#{cg}.png",
                  :icon_size          => GSize.new(16, 11),
                  :icon_anchor        => GPoint.new(8, 5),
                  :info_window_anchor => GPoint.new(8, 0)), 
                  "#{cg}_icon")
      assoc_icon = Variable.new("#{cg}_icon")    
      @map.overlay_init(GMarker.new(_assoc.coords, 
                                  :info_window => "<b>I'm a Popup window</b><br/>",
                                  :icon        => assoc_icon,
                                  :title       => _assoc.name))
    else
      @map.overlay_init(GMarker.new(_assoc.coords, 
                                    :info_window => "<b>I'm a Popup window</b><br/> #{Geokit::Geocoders::GoogleGeocoder.do_reverse_geocode(_assoc.coords).country_code}",
                                    :title       => _assoc.name)
                       )
    end

    unless _assoc.parent.nil?
      @map.overlay_init(GPolyline.new([_assoc.parent.coords, _assoc.coords], _color, 2, 0.2))
    end
  end
end
