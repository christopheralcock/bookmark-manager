feature 'Adding tags' do

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education ruby'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

  scenario 'If i do not tag a link, it gets tagged as untagged' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.monkeys.com/'
    fill_in 'title', with: 'Monkeys'
    fill_in 'tags',  with: ''
    click_button 'Create link'
    link = Link.first
    p link.tags.map(&:name)
    expect(link.tags.map(&:name)).to include('untagged')
  end

end
