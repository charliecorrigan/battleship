def ship_maker(ships)
    ships.each do |this_ship|
      place_ship_on_board(gameboard, this_ship, coordinate)

# def place_ships(gameboard, ships, size)
  #   ships.each do |this_ship|
  #     coordinate = select_random_coordinate(gameboard, size)
  #     valid = false
  #     until valid
  #       direction = select_random_direction
  #       current_coordinate = coordinate
  #       if direction == "up"
  #         (this_ship - 1).times do
  #           if current_coordinate.up == nil || current_coordinate.up.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.up
  #             valid = true
  #           end
  #         end
  #       elsif direction == "down"
  #         valid = (this_ship - 1).times do
  #           if current_coordinate.down == nil || current_coordinate.down.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.down
  #             valid = true
  #           end
  #         end
  #       elsif direction == "right"
  #         valid = (this_ship - 1).times do
  #           if current_coordinate.right == nil || current_coordinate.right.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.right
  #             valid = true
  #           end
  #         end
  #       else
  #         valid = (this_ship - 1).times do
  #           if current_coordinate.left == nil || current_coordinate.left.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.left
  #             valid = true
  #           end
  #         end
  #       end
  #       end
  #     current_coordinate = coordinate
  #     this_ship.times do
  #       if direction == "up"
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.up
  #       elsif direction == "down"
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.down
  #       elsif direction == "right"
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.right
  #       else
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.left
  #       end
  #     end
  #   end
  # end



  # def place_ships(gameboard, ships, size)
  #   ships.each do |this_ship|
  #     coordinate = select_random_coordinate(gameboard, size)
  #     valid = false
  #     until valid
  #       direction = select_random_direction
  #       current_coordinate = coordinate
  #       if direction == "up"
  #         (this_ship - 1).times do
  #           if current_coordinate.up == nil || current_coordinate.up.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.up
  #             valid = true
  #           end
  #         end
  #       elsif direction == "down"
  #         valid = (this_ship - 1).times do
  #           if current_coordinate.down == nil || current_coordinate.down.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.down
  #             valid = true
  #           end
  #         end
  #       elsif direction == "right"
  #         valid = (this_ship - 1).times do
  #           if current_coordinate.right == nil || current_coordinate.right.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.right
  #             valid = true
  #           end
  #         end
  #       else
  #         valid = (this_ship - 1).times do
  #           if current_coordinate.left == nil || current_coordinate.left.ship == true
  #             return valid = false
  #           else
  #             current_coordinate = current_coordinate.left
  #             valid = true
  #           end
  #         end
  #       end
  #       end
  #     current_coordinate = coordinate
  #     this_ship.times do
  #       if direction == "up"
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.up
  #       elsif direction == "down"
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.down
  #       elsif direction == "right"
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.right
  #       else
  #         current_coordinate.ship = true
  #         current_coordinate = current_coordinate.left
  #       end
  #     end
  #   end
  # end

  #  def select_random_direction
  #    value = rand(3)
  #    if value == 0
  #     direction = "up"
  #   elsif value == 1
  #     direction = "down"
  #   elsif value == 2
  #     direction = "right"
  #   else
  #     direction = "left"
  #   end
  #   direction
  # end
  
