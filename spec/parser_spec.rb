require 'rspec'

describe 'ScanlibsParse::Parser' do

  context 'with standard React+Flux content' do
    it '#video parse correctly' do
      content = 'Learning React.js with FluxEnglish | MP4 | AVC 1280×720 | AAC 48KHz 2ch | 3.5 Hours | 703 MB eLearning | Skill level: All Levels \r  (more…) Read More  '
      result = ScanlibsParse::Parser.video content
      #binding.pry
      expect(result).to_not eq nil
      expect(result.size).to eq 2
      expect(result[1].size).to eq 5
      expect(result[1][:format]).to eq 'MP4'
      expect(result[1][:resolution]).to eq '1280×720'
      expect(result[1][:duration]).to eq '3.5 Hours'
      expect(result[1][:size]).to eq %w(703 MB)
      expect(result[1][:skill_level]).to eq 'All Levels'
    end
  end

  context 'with weird Git Complete' do
    it '# parse correctly' do
      content = 'Git CompleteEnglish | MP4 | AVC 1280×720 | AAC 44KHz 2ch | 5 Hours | 1.07 GB eLearning | Skill level: All Levels \r  (more…) Read More  '
      result = ScanlibsParse::Parser.video content
      expect(result[1]).to_not eq nil
      expect(result.size).to eq 2
      expect(result[1].size).to eq 5
      expect(result[1][:format]).to eq 'MP4'
      expect(result[1][:resolution]).to eq '1280×720'
      expect(result[1][:duration]).to eq '5 Hours'
      expect(result[1][:size]).to eq %w(1.07 GB)
      expect(result[1][:skill_level]).to eq 'All Levels'
    end
  end
end