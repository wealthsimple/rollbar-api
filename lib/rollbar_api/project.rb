module RollbarApi
  class Project
    @@projects = {}

    def self.add(project_name, project_access_token)
      @@projects[project_name] = project_access_token
    end

    def self.find(project_name)
      project_access_token = @@projects[project_name]
      raise "No project #{project_name} configured" unless project_access_token.present?
      new(project_name, project_access_token)
    end

    def self.all
      @@projects.map { |project_name, _| find(project_name) }
    end

    attr_reader :name, :access_token
    def initialize(name, access_token)
      @name = name
      @access_token = access_token
    end

    def fetch(path, params = {})
      params[:access_token] = access_token
      response = Request.get!(path, params)
      if response.is_a?(Array)
        response.map { |r| Resource.new(r) }
      else
        Resource.new(response)
      end
    end
  end
end
