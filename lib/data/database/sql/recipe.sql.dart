

const getAllRecipes =
    'SELECT r.*, COALESCE(SUM(p.price * j.quantity), 0.0) as total FROM recipes r LEFT JOIN recipe_product_join j ON j.recipeId = r.id LEFT JOIN products p ON p.id = j.productId GROUP BY r.id, r.name';

const createRecipeView = '''
    CREATE VIEW recipe_with_total AS
    SELECT 
      r.id,
      r.name,
      COALESCE(SUM(p.price * j.quantity), 0.0) as total
    FROM recipes r
    LEFT JOIN recipe_product_join j ON j.recipe_id = r.id
    LEFT JOIN products p ON p.id = j.product_id
    GROUP BY r.id, r.name
  ''';


