require "rails_helper"

RSpec.describe TrelloBoard do

  it "All parameters are specified (with idList)" do
    code = TrelloBoard.new(board_id: '58b0667f928fa53177194eba').create_card!(title: 'asd', description: 'aaaaaa', list_id: '58b076ac83006d80aeb076ba')

    expect(code).to eq(200)
  end

  it "Not all parameters are specified (without idList)" do
    code = TrelloBoard.new(board_id: '58b0667f928fa53177194eba').create_card!(title: 'asd', description: 'aaaaaa')

    expect(code).not_to eq(200)
  end

	it "File with auth params not exist!" do
		ENV['HOME'] = SecureRandom.hex
    new_board = proc{ TrelloBoard.new(board_id: '58b0667f928fa53177194eba').create_card!(title: 'asd', description: 'aaaaaa') }

    expect(new_board).to raise_error(Errno::ENOENT)
  end
end