class RankingController < ApplicationController

    def have
        @title = "have"
        @ranking = ranking Have
        #@items = Have.group(:item_id).order('count_all desc').count.keys.map{|id| Item.find(id)}.first(10)
    end
    
    def want
        @title = "want"
        @ranking = ranking Want
        #@items = Want.group(:item_id).order('count_all desc').count.keys.map{|id| Item.find(id)}.first(10)
    end
    
    
    def ranking(model)
    items = []     # itemsとrankingのインデックスが対応している
    ranking = []   # 順位
    rankings = model.group("item_id").count.sort{|a, b| b.last <=> a.last}  # [[item_id, num], [4, 10], [2, 8], [9, 7]]
    rank = 0
    
    pre_n = 0
    rankings.each do |id, n|
      break if n.equal?(0)        # 誰も選んでいないものは除外
      if n != pre_n               # 同一順位を考慮して順位付けをする
        rank += 1
        pre_n = n
      end
      items.push(Item.find(id))
      ranking.push(rank)
      if 10 <= items.length      # 最大10こ
        break
      end
    end

    items.zip(ranking)   # [[Item, rank], ....]
  end
end
