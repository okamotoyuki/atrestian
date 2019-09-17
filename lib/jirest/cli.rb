require "jirest"
require "thor"

module Jirest

  DATA_DIR = './data'

  class Cli < Thor

    desc "describe", "Describe a Jira REST API."
    def describe
      command_generator = CommandExecutor.new
      command_generator.describe
    end

    desc "update", "Update all API information."
    def update
      api_def = Util::load_api_definition(DATA_DIR)
      ApiInfoUpdater.new(api_def).update
    end

    desc "dryrun", "Generate a curl command to call Jira REST API."
    def dryrun
      command_generator = CommandExecutor.new
      command_generator.dryrun
    end

    desc "exec", "Execute a curl command to call Jira REST API."
    def exec
      command_generator = CommandExecutor.new
      command_generator.exec
    end

    desc "edit", "Edit a template for Jira REST API."
    def edit
      command_generator = CommandExecutor.new
      command_generator.edit
    end

  end
end