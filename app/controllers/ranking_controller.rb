class RankingController < ApplicationController

def have
    @title = "had"
    @items = Have.group(:item_id).order('count_all desc').count.keys.map{|id| Item.find(id)}.first(10)
end

def want
    @title = "wanted"
    @items = Want.group(:item_id).order('count_all desc').count.keys.map{|id| Item.find(id)}.first(10)
end

end
