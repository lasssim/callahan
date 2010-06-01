class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.references :association
      t.references :owner
      t.references :players
      t.string :name
      t.string :abbrevation
      t.string :url

      t.timestamps
    end

    create_table :teams_players do |t|
      t.references :team
      t.references :player
    end

  end

  def self.down
    drop_table :teams
    drop_table :teams_players
  end
end
