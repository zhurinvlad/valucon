class TrelloApi
	TRELLO_URI = 'https://api.trello.com/'
	# b = TrelloBoard.new(board_id: '58b0667f928fa53177194eba').create_card!(title: 'asd', description: 'aaaaaa', list_id: '58b076ac83006d80aeb076ba')
	# b.create_card!(title: 'asd', description: 'aaaaaa', list_id: '58b076ac83006d80aeb076ba')
	def self.send_post_request(sub_url, data)
    url = URI.parse("#{TRELLO_URI}/1#{sub_url}")
		
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = url.scheme == "https"

    request = Net::HTTP::Post.new(url.request_uri)
    
    request.set_form_data(data.merge!(self.read_auth_data))

    response = http.request(request)
    
    code = response.code.to_i
		body = code == 200 ? JSON.parse(response.body) : response.body

    return code, body
	end

	private
	def self.read_auth_data
		path_file = "#{ENV['HOME']}/.trellorc"
		
		data = YAML.load_file(path_file)
		# if File.exists?(path_file)
		# 	data = YAML.load_file(path_file)
		# else
		#   data = {}
		# end

		raise 'Not all parameters for auth are specified' if data['developer_public_key'].nil? || data['member_token'].nil?
		
		auth_data = {
			key: data['developer_public_key'],
			token: data['member_token']
		}
	end
end

class TrelloBoard

	def initialize(attributes = {})
		@board_id = attributes[:board_id]
	end

	def create_card!(attributes = {})
		data = {
			name: attributes[:title],
			desc: attributes[:description],
			idList: attributes[:list_id],
			idBoard: @board_id
		}
		code, body = TrelloApi.send_post_request('/cards', data)

		if code == 200
			puts "Successful created! URL = #{body['url']}"
		else
			puts "Error create! Error = #{body}"
		end

		code
	end
end