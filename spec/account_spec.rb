describe RollbarApi::Account do
  describe ".configure" do
    it "adds a Account to list" do
      expect(RollbarApi::Account.find("my-org")).to be_nil

      RollbarApi::Account.configure("my-org", "my-token")

      project = RollbarApi::Account.find("my-org")
      expect(project).to be_a(RollbarApi::Account)
      expect(project.name).to eq("my-org")
      expect(project.access_token).to eq("my-token")
    end

    it "returns an Account" do
      expect(RollbarApi::Account.configure("my-org", "my-token")).to be_a(RollbarApi::Account)
    end
  end

  describe ".find" do
    before { RollbarApi::Account.configure("my-org", "my-token") }

    context "Account exists" do
      it "returns a Account" do
        expect(RollbarApi::Account.find("my-org")).to be_a(RollbarApi::Account)
      end
    end

    context "Account does not exist" do
      it "returns nil" do
        expect(RollbarApi::Account.find("my-org-2")).to be_nil
      end
    end
  end

  describe ".all" do
    it "returns all Accounts" do
      expect(RollbarApi::Account.all).to eq([])

      RollbarApi::Account.configure("my-org", "token1")
      RollbarApi::Account.configure("my-org-2", "token2")

      expect(RollbarApi::Account.all.size).to eq(2)
      expect(RollbarApi::Account.all.map(&:name)).to contain_exactly("my-org", "my-org-2")
    end
  end
end
