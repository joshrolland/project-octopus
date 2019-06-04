require 'rails_helper'

shared_examples "a failed import" do
  describe "#items" do
    it 'returns an empty list' do
      expect(subject.items).to be_empty
    end
  end
end

describe ContactImporter do
  # TOOD: partial success
  # TOOD: full success
  # TODO: duplicates - warning/silent/update?

  describe 'non-CSV file' do
    let!(:subject) { ContactImporter.new( Rails.root.join('spec', 'services', 'contact_csv_files', 'non_csv.txt') ) }
    it_behaves_like 'an invalid record'
    it_behaves_like 'a failed import'
    # TODO: errors hash check message
  end

  describe 'headerless CSV file' do
    let!(:subject) { ContactImporter.new( Rails.root.join('spec', 'services', 'contact_csv_files', 'headerless.csv') ) }
    it_behaves_like 'an invalid record'
    it_behaves_like 'a failed import'
    # TODO: errors hash check message
  end

  describe 'CSV file with invalid headers' do
    let!(:subject) { ContactImporter.new( Rails.root.join('spec', 'services', 'contact_csv_files', 'invalid_headers.csv') ) }
    it_behaves_like 'an invalid record'
    it_behaves_like 'a failed import'
    # TODO: errors hash check message
  end

  describe 'valid CSV with failed records' do
    let!(:subject) { ContactImporter.new( Rails.root.join('spec', 'services', 'contact_csv_files', 'invalid_records.csv') ) }
    it_behaves_like 'an invalid record'
    it_behaves_like 'a failed import'
    # TODO: errors hash check message
  end

  describe 'valid CSV with duplicates' do
    let!(:subject) { ContactImporter.new( Rails.root.join('spec', 'services', 'contact_csv_files', 'valid_duplicates.csv') ) }
    it_behaves_like 'an invalid record'
    it_behaves_like 'a failed import'
    # TODO: errors hash check message
  end

  describe 'valid CSV import' do
    let!(:subject) { ContactImporter.new( Rails.root.join('spec', 'services', 'contact_csv_files', 'valid.csv') ) }

    describe '#save' do
      let!(:save_result) { subject.save }

      it 'save returns true' do
        expect(save_result).to be_truthy
      end

      it 'has no errors' do
        expect(subject.errors).to be_empty
      end

      it 'creates new records' do
        expect(Contact.count).to eq(3)
      end
    end

    describe '#save!' do
      let!(:save_result) { subject.save! }

      it 'save returns true' do
        expect(save_result).to be_truthy
      end

      it 'has no errors' do
        expect(subject.errors).to be_empty
      end

      it 'creates new records' do
        expect(Contact.count).to eq(3)
      end
      # returns true
    end

    # TODO check everything's good
  end
end
