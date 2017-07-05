module RollbarApi
  class Project
    @@projects = {}

    def self.configure(project_name, project_access_token)
      @@projects[project_name] = project_access_token
    end

    def self.find(project_name)
      project_access_token = @@projects[project_name]
      new(project_name, project_access_token) if project_access_token.present?
    end

    def self.all
      @@projects.map { |project_name, _| find(project_name) }
    end

    def self.delete_all
      @@projects = {}
    end

    attr_reader :name, :access_token
    def initialize(name, access_token)
      @name = name
      @access_token = access_token
    end

    %i(get post put delete head patch).each do |http_method|
      define_method(http_method) do |path, params = {}|
        params[:access_token] = access_token
        response = Request.new(method: http_method, path: path, params: params).execute
        if response.is_a?(Array)
          response.map { |r| Resource.new(r) }
        else
          Resource.new(response)
        end
      end
    end
  end
end
