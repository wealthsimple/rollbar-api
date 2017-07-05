describe RollbarApi::Project do
  describe ".add" do
    it "adds a Project to list" do
      expect(RollbarApi::Project.find("my-project")).to be_nil

      RollbarApi::Project.configure("my-project", "my-token")

      project = RollbarApi::Project.find("my-project")
      expect(project).to be_a(RollbarApi::Project)
      expect(project.name).to eq("my-project")
      expect(project.access_token).to eq("my-token")
    end
  end

  describe ".find" do
    before { RollbarApi::Project.configure("my-project", "my-token") }

    context "Project exists" do
      it "returns a Project" do
        expect(RollbarApi::Project.find("my-project")).to be_a(RollbarApi::Project)
      end
    end

    context "Project does not exist" do
      it "returns nil" do
        expect(RollbarApi::Project.find("my-project-2")).to be_nil
      end
    end
  end

  describe ".all" do
    it "returns all Projects" do
      expect(RollbarApi::Project.all).to eq([])

      RollbarApi::Project.configure("my-project", "token1")
      RollbarApi::Project.configure("my-project-2", "token2")

      expect(RollbarApi::Project.all.size).to eq(2)
      expect(RollbarApi::Project.all.map(&:name)).to contain_exactly("my-project", "my-project-2")
    end
  end
end
