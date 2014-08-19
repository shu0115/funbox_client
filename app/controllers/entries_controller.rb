class EntriesController < UITableViewController
  # ビューが読み込まれた後で実行されるメソッド
  # def viewDidLoad
  #   super
  #   @tag = 'RubyMotion'
  #   self.title = @tag # ナビゲーションバーのタイトルを変更
  #   @entries = [] # 取得したエントリをこのインスタンス変数に格納
  #   url = "https://qiita.com/api/v1/tags/#{@tag}/items"

  #   # 前回に引き続き BubbleWrap を使う
  #   BW::HTTP.get(url) do |response|
  #     if response.ok?
  #       json = BW::JSON.parse(response.body.to_s)
  #       @entries = json
  #       self.tableView.reloadData # テーブルをリロード
  #     else
  #       p response.error_message
  #     end
  #   end
  # end
  # ↓
  def viewDidLoad
    super
    self.tableView.registerClass(EntryCell, forCellReuseIdentifier:'Entry')
    @tag = 'RubyMotion'
    self.title = @tag
    @entries = []

    Qiita::Client.fetch_tagged_items(@tag) do |items, error_message|
      if error_message.nil?
        @entries = items
        self.tableView.reloadData
      else
        p error_message
      end
    end
  end

  # テーブルの行数を返すメソッド
  def tableView(tableView, numberOfRowsInSection:section)
    @entries.count
  end

  # テーブルのセルを返すメソッド
  ENTRY_CELL_ID = 'Entry'
  # def tableView(tableView, cellForRowAtIndexPath:indexPath)
  #   cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)

  #   if cell.nil?
  #     cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
  #   end

  #   entry = @entries[indexPath.row]

  #   # ラベルをセット
  #   cell.textLabel.text = entry['title']
  #   cell.detailTextLabel.text = "#{entry['updated_at_in_words']} by #{entry['user']['url_name']}"
  #   cell
  # end
  # ↓
  # def tableView(tableView, cellForRowAtIndexPath:indexPath)
  #   cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)
  #   if cell.nil?
  #     cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
  #   end
  #   entry = @entries[indexPath.row]
  #   cell.textLabel.text = entry.title
  #   cell.detailTextLabel.text = "#{entry.updated_at} by #{entry.username}"
  #   cell
  # end
  # ↓
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID, forIndexPath:indexPath)
    entry = @entries[indexPath.row]
    cell.entry = entry
    cell.setNeedsDisplay # 再描画させる
    cell
  end

  # def tableView(tableView, didSelectRowAtIndexPath:indexPath)
  #   entry = @entries[indexPath.row]
  #   body = entry['body']

  #   # UIWebView を貼り付けたビューコントローラを作成
  #   controller = UIViewController.new
  #   webview = UIWebView.new
  #   webview.frame = controller.view.frame # webview の表示サイズを調整
  #   controller.view.addSubview(webview)

  #   # 画面遷移
  #   navigationController.pushViewController(controller, animated:true)

  #   # HTML を読み込む
  #   webview.loadHTMLString(body, baseURL:nil)
  # end
  # ↓
  # def tableView(tableView, didSelectRowAtIndexPath:indexPath)
  #   entry = @entries[indexPath.row]

  #   # UIWebView を貼付けた ビューコントローラを作成
  #   controller = UIViewController.new
  #   webview = UIWebView.new
  #   webview.frame = controller.view.frame # webview の表示サイズを調整
  #   controller.view.addSubview(webview)

  #   # 画面遷移
  #   navigationController.pushViewController(controller, animated:true)

  #   # HTML を読み込む
  #   webview.loadHTMLString(entry.body, baseURL:nil)
  # end
  # ↓
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    entry = @entries[indexPath.row]
    controller = EntryController.new
    controller.entry = entry
    # 画面遷移
    navigationController.pushViewController(controller, animated:true)
  end
end

