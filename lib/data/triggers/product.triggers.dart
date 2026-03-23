const String updateRecipePriceOnProductUpdate = '''
  CREATE TRIGGER IF NOT EXISTS update_recipe_price_on_product_update
  AFTER UPDATE OF price ON Products
  BEGIN
    UPDATE Recipes
    SET price = (
      SELECT ROUND(SUM(p.price * rpj.requiredQuantity), 2)
      FROM recipe_product_join rpj
      JOIN Products p ON p.id = rpj.productId
      WHERE rpj.recipeId = Recipes.id
    )
    WHERE id IN (
      SELECT recipeId 
      FROM recipe_product_join 
      WHERE productId = NEW.id
    );
  END;
''';