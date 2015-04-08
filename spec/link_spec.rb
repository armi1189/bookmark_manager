describe Link do

  context 'Demostration of how datamapper works' do
    it 'is created and then retrieved from the db' do
      expect(described_class.count).to eq(0)
      described_class.create(title: 'Makers Academy',
                             url: 'http://www.makersacademy.com/')
      expect(described_class.count).to eq(1)
      link = described_class.first
      expect(link.url).to eq('http://www.makersacademy.com/')
      expect(link.title).to eq('Makers Academy')
      link.destroy
      expect(described_class.count).to eq(0)
    end
  end

end