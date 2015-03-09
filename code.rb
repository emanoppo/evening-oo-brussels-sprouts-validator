class Ingredient
  def initialize(quantity, unit, name)
    @quantity = quantity
    @unit = unit
    @name = name
  end

  def summary
    "#{@quantity} #{@unit} #{@name}"
  end

  def safe?
    safe_foods = ["brussels sprouts", "spinach", "eggs", "milk", "tofu", "seitan", "bell peppers", "quinoa", "kale", "chocolate", "beer", "wine", "whiskey"]
    safe_foods.include?(@name.downcase)
  end

  def self.parse(ingredient)
    ingredient = ingredient.split
    quantity = ingredient.shift.to_f.round(2)
    unit = ingredient.shift
    name = ingredient.join(' ')
    Ingredient.new(quantity, unit, name)
  end
end

class Recipe
  def initialize(name, instructions, ingredients)
    @name = name
    @instructions = instructions
    @ingredients = ingredients
  end

  def summary
    <<-SUMMARY
Name: #{@name}

Ingredients
#{ingredients_list}

Instructions
#{instructions_list}
    SUMMARY
  end

  def ingredients_list
    ingredients_print = ""
    @ingredients.each do |ingredient|
      ingredients_print = ingredients_print + "- #{ingredient.summary}\n"
    end
    ingredients_print
  end

# Would be more efficient to use each_with_index to iterate here, and << to add string.
  def instructions_list
    instructions_print = ""
    (1..@instructions.length).each do |count|
      instructions_print = instructions_print + "#{count}. #{@instructions[count - 1]}\n"
    end
    instructions_print
  end

  def safe?
    dangerous = false
    @ingredients.each do |ingredient|
      unless ingredient.safe?
        dangerous = true
      end
    end
    !dangerous
  end
end

name = "Double Chocolate Torte"

ingredients = [
  Ingredient.new(8, "ounces", "bittersweet (not unsweetened) or semisweet chocolate, chopped"),
  Ingredient.new(1, "cup", "unsalted butter"),
  Ingredient.new(1, "cup", "sugar"),
  Ingredient.new(5, "large", "eggs"),
  Ingredient.new(1, "tablespoon", "vanilla extract"),
  Ingredient.new(0.25, "teaspoon", "salt"),
  Ingredient.new(0.25, "cup", "all purpose flour"),
  Ingredient.new(0.5, "cup", "unsalted butter, cut into pieces"),
  Ingredient.new(4, "large", "eggs, separated"),
  Ingredient.new(1, "cup", "whipping cream"),
  Ingredient.new(1, "tablespoon", "vanilla extract"),
  Ingredient.new(8, "ounces", "bittersweet (not unsweetened) or semisweet chocolate, chopped"),
  Ingredient.new(0.5, "cup", "plus 1 1/2 teaspoons sugar"),
  Ingredient.new(2, "cups", "fresh raspberries"),
  Ingredient.new(2, "tablespoons", "red currant jelly melted with 1 tablespoon water")
]

instructions = [
  "Preheat oven to 325°F.",
  "Butter 10-inch-diameter springform pan; dust with sugar.",
  "Melt chocolate and butter in heavy large saucepan over low heat, stirring constantly. Cool to lukewarm.",
  "Whisk in sugar.",
  "Whisk in eggs 1 at a time, blending well after each addition.",
  "Mix in vanilla and salt, then flour.",
  "Pour batter into pan. Bake until cake just rises in center (tester inserted into center will not come out clean), about 35 minutes.",
  "Cool completely in pan on rack.",
  "Cover; chill while making mousse.",
  "Melt butter in medium metal bowl set over saucepan of simmering water (do not allow bottom of bowl to touch water).",
  "Whisk yolks, 1/4 cup cream and vanilla in small bowl to blend.",
  "Gradually whisk yolk mixture into bowl with melted butter.",
  "Whisk constantly over simmering water until thermometer registers 150°F, about 6 minutes (mixture may appear broken).",
  "Remove from over water; add chocolate and stir to melt. Set aside.",
  "Beat egg whites and 1/2 cup sugar in large bowl to medium-stiff peaks.",
  "Whisk 1/4 of beaten egg white mixture into warm chocolate mixture to lighten.",
  "Fold in remaining egg white mixture.",
  "Pour mousse over cake in pan; smooth top.",
  "Chill torte until mousse is set, at least 6 hours and up to 1 day.",
  "Run sharp knife around edge of pan to loosen torte. Release pan sides. Transfer torte to platter.",
  "Using electric mixer, beat 3/4 cup cream in medium bowl until peaks form.",
  "Spread whipped cream over torte.",
  "Top whipped cream with raspberries.",
  "Brush red currant jelly mixture over raspberries.",
  "Sprinkle with 1 1/2 teaspoons sugar. Garnish with currants, if desired."
]

recipe = Recipe.new(name, instructions, ingredients)
puts recipe.summary

puts recipe.safe?

name = "Test Recipe"

ingredients = [
  Ingredient.new(1, "cup", "milk"),
  Ingredient.new(2, "cups", "chocolate")
]

instructions = [
  "Mix the milk and chocolate.",
  "You are done."
]

recipe = Recipe.new(name, instructions, ingredients)
puts recipe.summary

puts recipe.safe?

puts Ingredient.parse("47 lb(s) Brussels sprouts").summary
puts Ingredient.parse("5 tspn(s) milk").summary
