require 'csv'

namespace :import_csv do
  desc "CSVデータをインポートするタスク"
  task users: :environment do
    # インポートするファイルのパスを取得
    path = File.join Rails.root, "db/csv_data/csv_data.csv"
    # インポートするデータを格納するための配列
    list = []
    # CSVファイルからインポートするデータを取得し配列に格納
    CSV.foreach(path, headers: true) do |row|
      list << {
        name: row["name"],
        age: row["age"],
        address: row["address"]
      }
    end
    puts "インポート処理を開始します"
    # インポートができなかった場合の例外処理
    begin
      User.create!(list)
      puts "インポートが完了しました"
    rescue Activmodel::UnknownAttributeError => invalid
      puts "インポートに失敗しました:UnknownAttributeError"
    end
  end
end
