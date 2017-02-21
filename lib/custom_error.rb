module CustomError
	class BadVersionSHA < StandardError
		def to_s
        	"Gem file's sha incorrect!"
        end
	end
	class GemFileNotExist < StandardError
		def to_s
        	"Gem file doesn't exist!"
        end
	end
end