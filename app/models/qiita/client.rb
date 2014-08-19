module Qiita
  class Client
    BASE_URL = 'https://qiita.com/api/v1'

    # Qiita API にアクセスして特定のタグがつけられた投稿を取得する
    #
    # @example
    #   Qiita::Client.fetch_tagged_items('tag') {|items, error_message|
    #     # 任意の処理
    #   }
    #

    def self.fetch_tagged_items(tag_name, &block)
      url = BASE_URL + "/tags/#{tag_name}/items"

      BW::HTTP.get(url) do |response|
        items = []
        message = nil
        begin
          if response.ok?
            json = BW::JSON.parse(response.body.to_s)
            # 1 件ずつ Qiita::Item クラスのインスタンスにして格納
            items = json.map { |data| Qiita::Item.new(data) }
          else
            # エラーが起きた場合は message 変数にエラー内容を格納
            if response.body.nil?
              message = response.error_message
            else
              json = BW::JSON.parse(response.body.to_s)
              message = json['error']
            end
          end
        rescue => e
          p e
          items = []
          message = 'Error'
        end
        block.call(items, message)
      end
    end
  end
end
