class TournamentReportsController < ApplicationController
 
 filter_resource_access
 
  uses_tiny_mce :options => {
                              :theme => 'advanced',
                              :theme_advanced_resizing => true,
                              :theme_advanced_resize_horizontal => false,
                              :plugins => %w{ table fullscreen }
                            }
 
  require 'googlecalendar'
  
  helper CalendarHelper
  # GET /tournament_reports
  # GET /tournament_reports.xml
  def index
    @tournament_reports = TournamentReport.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @tournament_reports }
    #end

    require 'gcal4ruby'
    gcservice = GCal4Ruby::Service.new
    gcservice.authenticate('Support.Callahan@gmail.com', 'callahan4ultimate')
    @calendar = gcservice.calendars.first
    #@calendar.to_iframe({:showTitle => false,
    #               :showNav => false,
    #               :showPrint => false,
    #               :showTabs => false,
    #               :showCalendars => false,
    #               :showTimezone => false,
    #               :viewMode => 'AGENDA'})
    
    #g = GData.new
    #g.login('Rene.Swoboda@gmail.com', 'r79zx4tauren#')
    #@cal = g.find_calendar('Callahan')
    #@cal.to_s()
    
    @date = Time.parse("#{params[:date]} || Time.now")
  end

  # GET /tournament_reports/1
  # GET /tournament_reports/1.xml
  def show
    @tournament_report = TournamentReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament_report }
    end
  end

  # GET /tournament_reports/new
  # GET /tournament_reports/new.xml
  def new
    @tournament_report = TournamentReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tournament_report }
    end
  end

  # GET /tournament_reports/1/edit
  def edit
    @tournament_report = TournamentReport.find(params[:id])
  end

  # POST /tournament_reports
  # POST /tournament_reports.xml
  def create
    @tournament_report = TournamentReport.new(params[:tournament_report])

    respond_to do |format|
      if @tournament_report.save
        flash[:notice] = 'TournamentReport was successfully created.'
        format.html { redirect_to(@tournament_report) }
        format.xml  { render :xml => @tournament_report, :status => :created, :location => @tournament_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tournament_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tournament_reports/1
  # PUT /tournament_reports/1.xml
  def update
    @tournament_report = TournamentReport.find(params[:id])

    respond_to do |format|
      if @tournament_report.update_attributes(params[:tournament_report])
        flash[:notice] = 'TournamentReport was successfully updated.'
        format.html { redirect_to(@tournament_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tournament_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament_reports/1
  # DELETE /tournament_reports/1.xml
  def destroy
    @tournament_report = TournamentReport.find(params[:id])
    @tournament_report.destroy

    respond_to do |format|
      format.html { redirect_to(tournament_reports_url) }
      format.xml  { head :ok }
    end
  end
end
