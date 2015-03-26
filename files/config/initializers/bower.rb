bower_root = Rails.root.join('vendor', 'assets', 'bower_components')

bower_jsons = Dir[bower_root.join("*", "bower.json")]

bower_asset_paths = bower_jsons.flat_map{|bower_json|
  main_sources = [JSON.parse(File.read(bower_json))["main"]].flatten
  main_sources.map { |path|
    File.expand_path("../#{File.dirname(path)}", bower_json)
  }.uniq
}

config = Rails.application.config
config.assets.paths += bower_asset_paths
config.sass.load_paths += bower_asset_paths
