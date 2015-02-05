module NavHelper

    def item_for_id(id, item)
        items = @items.select do |i|
            i[:id] == id
        end

        # found an item?
        if items.length > 0
            return items[0]
        end

        # nothing found
        nil
    end

end
