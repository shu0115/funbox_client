module Qiita
  class Item
    # 必要な値のみ保持する
    attr_accessor :title, :username, :updated_at, :body

    def initialize(data)
      @title      = data['title']
      @username   = data['user']['url_name']
      @updated_at = data['updated_at_in_words']
      @body       = data['body']
    end
  end
end
