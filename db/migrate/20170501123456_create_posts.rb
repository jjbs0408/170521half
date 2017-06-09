class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      # 제목
      t.text :content
      # 리뷰
      t.string :start_date
      t.string :end_date

      # 출발~도착
      t.string :place
      # 장소
      t.string :abroad
      # 국내,국외
      t.string :img
      t.string :img_thumb

      t.belongs_to :user
      t.string :theme
      #달 표시
      t.timestamps
    end
  end
end
