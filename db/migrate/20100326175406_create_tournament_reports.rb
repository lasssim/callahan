class CreateTournamentReports < ActiveRecord::Migration
  def self.up
    create_table :tournament_reports do |t|
      t.string :title
      t.integer :team_id
      t.string :creator
      t.timestamp :updated
      t.timestamp :created
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :tournament_reports
  end
end
