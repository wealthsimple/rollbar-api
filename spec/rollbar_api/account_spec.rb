# frozen_string_literal: true

describe RollbarApi::Account do
  describe '.configure' do
    it 'adds a Account to list' do
      expect(described_class.find('my-org')).to be_nil

      described_class.configure('my-org', 'my-token')

      project = described_class.find('my-org')
      expect(project).to be_a(described_class)
      expect(project.name).to eq('my-org')
      expect(project.access_token).to eq('my-token')
    end

    it 'returns an Account' do
      expect(described_class.configure('my-org', 'my-token')).to be_a(described_class)
    end
  end

  describe '.find' do
    before { described_class.configure('my-org', 'my-token') }

    context 'Account exists' do
      it 'returns a Account' do
        expect(described_class.find('my-org')).to be_a(described_class)
      end
    end

    context 'Account does not exist' do
      it 'returns nil' do
        expect(described_class.find('my-org-2')).to be_nil
      end
    end
  end

  describe '.all' do
    it 'returns all Accounts' do
      expect(described_class.all).to eq([])

      described_class.configure('my-org', 'token1')
      described_class.configure('my-org-2', 'token2')

      expect(described_class.all.size).to eq(2)
      expect(described_class.all.map(&:name)).to contain_exactly('my-org', 'my-org-2')
    end
  end
end
