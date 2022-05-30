require 'yaml'

module SaveLoad
  def save_game
    File.open('saved_game.yml', 'w+') do |file|
      YAML.dump([] << self, file)
    end
  end

  def load_game
    yaml = YAML.load_file('saved_game.yml')
    @board = yaml[0].board
  end
end
