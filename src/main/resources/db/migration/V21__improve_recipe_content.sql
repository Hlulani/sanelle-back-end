-- V21: explicit recipe methods, input state and traceable cooking checks.
-- Authored from the existing seed recipes; timings are editorial estimates, not kitchen-tested.
-- Source URLs and before/after content are documented in docs/recipes/recipe-content-v1.json.
-- Protect custom edits: replace only an exact match of the original ingredients and ordered instructions.
ALTER TABLE meals ADD COLUMN recipe_content JSONB;
DO $recipe_revision$
DECLARE
    recipe JSONB;
    target_id UUID;
    original_steps JSONB;
    original_ingredients JSONB;
    changed_count INTEGER := 0;
BEGIN
    FOR recipe IN SELECT value FROM jsonb_array_elements($recipe_payload$[
  {
    "name": "Apple Cinnamon Oatmeal",
    "newName": "Apple Cinnamon Oatmeal",
    "expectedIngredients": [
      {
        "name": "Apple",
        "amount": "1/2, diced"
      },
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Milk or water",
        "amount": "1 cup"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      },
      {
        "name": "Walnuts",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Cook oats with milk/water.",
      "Stir in apple and cinnamon.",
      "Top with walnuts."
    ],
    "instructions": [
      "Dice the apple into small pieces; roughly chop the walnuts.",
      "Bring the milk or water to a gentle boil in a small saucepan. Stir in the rolled oats and diced apple.",
      "Reduce to medium-low and simmer for about 5-7 minutes, stirring regularly, until the oats are creamy and the apple is tender. Add a splash of water if needed.",
      "Stir in the cinnamon, spoon into a bowl and scatter over the walnuts."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.quakeroats.com/products/hot-cereals/old-fashioned-oats"
      ]
    }
  },
  {
    "name": "Apple with Almond Butter",
    "newName": "Apple with Almond Butter",
    "expectedIngredients": [
      {
        "name": "Almond butter",
        "amount": "1 tbsp"
      },
      {
        "name": "Apple",
        "amount": "1"
      }
    ],
    "expectedInstructions": [
      "Slice apple.",
      "Serve with almond butter.",
      "Eat immediately."
    ],
    "instructions": [
      "Wash and dry the apple, cut it into wedges and remove the core.",
      "Measure the almond butter into a small bowl or spread it onto the apple wedges.",
      "Serve the prepared apple straight away."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Avocado Tomato Toast",
    "newName": "Avocado Tomato Toast",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Cherry tomatoes",
        "amount": "6"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Wholegrain bread",
        "amount": "2 slices"
      }
    ],
    "expectedInstructions": [
      "Toast the bread.",
      "Mash avocado with lemon and salt.",
      "Spread on toast and top with tomatoes."
    ],
    "instructions": [
      "Wash the tomatoes and cut them in halves or quarters. Halve the avocado, remove the stone and scoop out the flesh.",
      "Toast the wholegrain bread until crisp, about 2-3 minutes depending on the toaster.",
      "Mash the avocado with the lemon juice and salt using a fork.",
      "Spread onto the toast, add the tomatoes and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Avocado Yogurt Dip Plate",
    "newName": "Avocado Yogurt Dip Plate",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Cucumber",
        "amount": "1/2"
      },
      {
        "name": "Greek yogurt",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Mash avocado with yogurt.",
      "Slice cucumber.",
      "Use cucumber to scoop dip."
    ],
    "instructions": [
      "Wash the cucumber and cut it into sticks or thick rounds.",
      "Halve and stone the avocado; scoop its flesh into a bowl.",
      "Mash the avocado with the Greek yogurt until smooth enough for dipping.",
      "Arrange the cucumber beside the dip and serve immediately, or keep covered in the fridge until serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Baked Cod with Lemon and Greens",
    "newName": "Baked Cod with Lemon and Greens",
    "expectedIngredients": [
      {
        "name": "Cod",
        "amount": "180 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Spinach",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Bake cod with olive oil, salt, and lemon.",
      "Sauté spinach until wilted.",
      "Serve fish with greens."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Use fresh or fully thawed cod and pat it dry; place it in a small baking dish.",
      "Coat the cod with about half the olive oil, the lemon juice and the salt.",
      "Bake for about 12-15 minutes; a thick fillet may need longer. Check the fish in its thickest part using the fish cooking check below before serving.",
      "While the fish bakes, warm the remaining oil in a frying pan over medium heat. Add the spinach and stir for about 2-3 minutes until wilted.",
      "Plate the cod with the spinach and spoon over the juices from the baking dish."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://media3.neff-international.com/Documents/MCDOC02081769_NEFF_Recipe_A4_Cod_Bake.pdf"
      ]
    }
  },
  {
    "name": "Baked Salmon with Sweet Potato",
    "newName": "Baked Salmon with Sweet Potato",
    "expectedIngredients": [
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salmon",
        "amount": "180 g"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Sweet potato",
        "amount": "1 medium"
      }
    ],
    "expectedInstructions": [
      "Bake sweet potato until soft.",
      "Bake salmon with olive oil and salt.",
      "Serve together."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Wash the sweet potato and cut it into roughly 2 cm cubes.",
      "Toss the sweet potato with about half the olive oil and the salt. Spread in one layer on a baking tray and roast for about 20 minutes.",
      "Place the fresh or fully thawed salmon in a small baking dish and coat it with the remaining oil.",
      "Put the salmon in the oven beside the sweet potato for about 12-15 minutes. Continue roasting the potato until a fork slides through it easily, turning the pieces once.",
      "Check the thickest part of the salmon using the fish cooking check below; cook longer if needed, then serve with the tender sweet potato."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Baked Tofu with Roasted Veggies",
    "newName": "Baked Tofu with Roasted Veggies",
    "expectedIngredients": [
      {
        "name": "Broccoli",
        "amount": "2 cups"
      },
      {
        "name": "Carrots",
        "amount": "1 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Soy sauce",
        "amount": "1 tbsp"
      },
      {
        "name": "Tofu",
        "amount": "250 g"
      }
    ],
    "expectedInstructions": [
      "Roast veggies with olive oil until tender.",
      "Bake tofu until firm.",
      "Drizzle soy sauce and serve."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C and line a baking tray. Drain firm tofu, pat it dry and cut it into about 2 cm cubes.",
      "Cut the carrots into thin batons and the broccoli into small florets. Toss these and the tofu with the olive oil.",
      "Arrange on the tray in a single layer, leaving space between pieces. Bake for about 25-30 minutes, turning the tofu and vegetables halfway through.",
      "Check that the carrots are tender and the tofu has lightly browned edges; return any pieces that need longer to the oven.",
      "Drizzle the soy sauce over the cooked tofu and vegetables and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use firm tofu, drained and patted dry, so it holds its shape when cooked."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.bbcgoodfoodme.com/recipes/roasted-vegetables/"
      ]
    }
  },
  {
    "name": "Banana Cinnamon Snack",
    "newName": "Banana Cinnamon Snack",
    "expectedIngredients": [
      {
        "name": "Banana",
        "amount": "1"
      },
      {
        "name": "Cinnamon",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Peel banana.",
      "Sprinkle cinnamon.",
      "Eat."
    ],
    "instructions": [
      "Peel the banana and slice it onto a plate.",
      "Sprinkle the cinnamon over the slices and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Bean Chili (Quick)",
    "newName": "Bean Chili (Quick)",
    "expectedIngredients": [
      {
        "name": "Black beans",
        "amount": "1 can"
      },
      {
        "name": "Chili powder",
        "amount": "1 tsp"
      },
      {
        "name": "Kidney beans",
        "amount": "1 can"
      },
      {
        "name": "Onion",
        "amount": "1/2"
      },
      {
        "name": "Tomato passata",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Sauté onion.",
      "Add beans and passata with chili powder.",
      "Simmer 10–15 minutes."
    ],
    "instructions": [
      "Use canned black and kidney beans. Drain and rinse them; finely dice the onion.",
      "Put the onion in a saucepan with 2 tablespoons of water. Cook over medium heat for about 4-5 minutes, stirring and adding a little water if it starts to catch.",
      "Stir in the chili powder, passata and drained beans. Bring to a gentle bubble.",
      "Reduce to low and simmer for about 10-15 minutes, stirring occasionally, until the onion is tender and the chili is hot throughout. Add a splash of water if it becomes too thick.",
      "Spoon into a bowl and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Bean Tuna Salad",
    "newName": "Bean Tuna Salad",
    "expectedIngredients": [
      {
        "name": "Kidney beans",
        "amount": "1/2 can"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Tuna",
        "amount": "1 can"
      }
    ],
    "expectedInstructions": [
      "Drain tuna and beans.",
      "Mix with lemon and olive oil.",
      "Serve."
    ],
    "instructions": [
      "Use canned tuna and canned kidney beans; drain both and rinse the beans.",
      "Flake the tuna into a bowl and fold in the beans.",
      "Mix the lemon juice and olive oil, then stir through the tuna and beans.",
      "Serve straight away or keep covered and refrigerated until serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Bean and Corn Salsa Bowl",
    "newName": "Bean and Corn Salsa Bowl",
    "expectedIngredients": [
      {
        "name": "Black beans",
        "amount": "1/2 can"
      },
      {
        "name": "Cilantro",
        "amount": "1 tbsp"
      },
      {
        "name": "Corn",
        "amount": "1/2 cup"
      },
      {
        "name": "Lime juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Tomatoes",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Mix beans, corn, and tomatoes.",
      "Add lime juice and cilantro.",
      "Serve as a bowl."
    ],
    "instructions": [
      "Drain and rinse the canned black beans. Use drained canned corn or corn cooked and cooled according to its packet.",
      "Dice the tomatoes and chop the cilantro.",
      "Combine the beans, corn and tomatoes in a bowl.",
      "Toss with the lime juice and cilantro, then serve or refrigerate promptly."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Beef Spinach Rice Bowl",
    "newName": "Beef Spinach Rice Bowl",
    "expectedIngredients": [
      {
        "name": "Cooked rice",
        "amount": "1 cup"
      },
      {
        "name": "Lean beef strips",
        "amount": "180 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Spinach",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Cook beef in olive oil until browned.",
      "Add spinach until wilted.",
      "Serve over rice."
    ],
    "instructions": [
      "Use cooked rice, prepared separately according to its packet. Slice the beef into thin, even strips and keep raw meat separate from the other ingredients.",
      "Heat the olive oil in a frying pan over medium-high heat. Add the beef in one layer and cook for about 3-5 minutes, turning so each side browns.",
      "Check the beef using the whole-cut beef cooking check below; browning alone does not establish doneness. Remove it to a clean plate and let it rest for 3 minutes.",
      "Add the spinach and salt to the pan and stir over medium heat for about 1-2 minutes until wilted.",
      "Reheat chilled cooked rice until steaming hot throughout, then top with the spinach and rested beef."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked rice. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "whole-cut-meat",
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Beef and Veggie Skillet",
    "newName": "Beef and Veggie Skillet",
    "expectedIngredients": [
      {
        "name": "Bell pepper",
        "amount": "1/2"
      },
      {
        "name": "Lean ground beef",
        "amount": "200 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Onion",
        "amount": "1/2"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Brown beef in a pan.",
      "Add onion and pepper, cook until soft.",
      "Stir in spinach until wilted."
    ],
    "instructions": [
      "Dice the onion and bell pepper; wash and dry the spinach.",
      "Heat the olive oil in a frying pan over medium heat. Add the onion and pepper and stir for about 4-5 minutes until starting to soften.",
      "Add the ground beef and break it into small pieces with a spatula. Cook for about 6-8 minutes, stirring regularly.",
      "Check the ground beef using the ground-meat cooking check below; continue cooking if needed.",
      "Stir in the spinach for about 1-2 minutes until wilted, then serve hot."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "ground-meat",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Berry Spinach Smoothie",
    "newName": "Berry Spinach Smoothie",
    "expectedIngredients": [
      {
        "name": "Banana",
        "amount": "1/2"
      },
      {
        "name": "Greek yogurt",
        "amount": "1/2 cup"
      },
      {
        "name": "Mixed berries",
        "amount": "1 cup"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Water",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Add all ingredients to blender.",
      "Blend until smooth.",
      "Adjust water to desired thickness."
    ],
    "instructions": [
      "Wash fresh berries and spinach. If using frozen berries, follow the packet directions before blending.",
      "Peel the banana and put it in a blender with the berries, spinach, yogurt and measured water.",
      "Blend for about 30-60 seconds until smooth, stopping to scrape down the sides if needed.",
      "Add a little more water only if needed for your preferred texture; blend again and serve promptly."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Follow frozen fruit packet instructions; some berries must be heated and cooled before being eaten."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Boiled Eggs with Salt",
    "newName": "Boiled Eggs with Salt",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Boil eggs until firm.",
      "Peel eggs.",
      "Season lightly with salt."
    ],
    "instructions": [
      "Bring a small saucepan of water to a gentle boil, with enough water to cover the eggs.",
      "Lower the eggs in carefully with a spoon and simmer for about 10-12 minutes for firm yolks; egg size can change the time.",
      "Transfer to cold water, then peel once cool enough to handle.",
      "Check that the yolks and whites are firm, halve and season with the salt."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.fda.gov/food/buy-store-serve-safe-food/what-you-need-know-about-egg-safety"
      ]
    }
  },
  {
    "name": "Chicken Avocado Salad",
    "newName": "Chicken Avocado Salad",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Cooked chicken",
        "amount": "150 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Lettuce",
        "amount": "2 cups"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Chop chicken and avocado.",
      "Combine with lettuce.",
      "Dress with olive oil and lemon."
    ],
    "instructions": [
      "Use chicken that has already been fully cooked and safely chilled; this is not a method for raw chicken.",
      "Wash and dry the lettuce. Dice or slice the cooked chicken and avocado.",
      "Mix the lemon juice and olive oil in a small bowl.",
      "Toss the chicken, avocado and lettuce with the dressing and serve promptly."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked chicken. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chicken Rice Soup",
    "newName": "Chicken Rice Soup",
    "expectedIngredients": [
      {
        "name": "Carrot",
        "amount": "1"
      },
      {
        "name": "Chicken stock",
        "amount": "3 cups"
      },
      {
        "name": "Cooked chicken",
        "amount": "120 g"
      },
      {
        "name": "Cooked rice",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Simmer carrot in stock until soft.",
      "Add chicken and rice.",
      "Warm through and serve."
    ],
    "instructions": [
      "Use chicken and rice that have already been fully cooked. Peel and finely dice the carrot; cut or shred the cooked chicken.",
      "Bring the stock to a boil in a saucepan. Add the carrot, reduce to a gentle simmer and cook for about 8-10 minutes until tender.",
      "Stir in the cooked chicken and rice. Simmer for about 3-5 minutes, stirring, until the soup is hot throughout.",
      "Check the reheating guidance below for chilled cooked ingredients; serve immediately once they are thoroughly reheated."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked chicken, Cooked rice. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Chicken Veggie Soup",
    "newName": "Chicken Veggie Soup",
    "expectedIngredients": [
      {
        "name": "Carrot",
        "amount": "1"
      },
      {
        "name": "Celery",
        "amount": "1 stalk"
      },
      {
        "name": "Chicken stock",
        "amount": "3 cups"
      },
      {
        "name": "Cooked chicken",
        "amount": "120 g"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Simmer carrot and celery in stock.",
      "Add chicken and warm through.",
      "Season and serve."
    ],
    "instructions": [
      "Use fully cooked chicken. Dice the carrot and celery; cut or shred the chicken.",
      "Bring the stock to a boil in a saucepan. Add the carrot and celery and simmer over low-medium heat for about 8-10 minutes until tender.",
      "Add the cooked chicken and salt. Simmer for about 3-5 minutes, stirring, until hot throughout.",
      "Check the reheating guidance below when using chilled cooked chicken, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked chicken. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Chickpea Coconut Curry",
    "newName": "Chickpea Coconut Curry",
    "expectedIngredients": [
      {
        "name": "Chickpeas",
        "amount": "1 can"
      },
      {
        "name": "Coconut milk",
        "amount": "1 cup"
      },
      {
        "name": "Curry powder",
        "amount": "1 tbsp"
      },
      {
        "name": "Onion",
        "amount": "1/2"
      },
      {
        "name": "Spinach",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Sauté onion with curry powder.",
      "Add chickpeas and coconut milk, simmer 10 min.",
      "Stir in spinach until wilted."
    ],
    "instructions": [
      "Drain and rinse the canned chickpeas; finely dice the onion and wash the spinach.",
      "Put the onion in a saucepan with 2 tablespoons of water. Cook over medium heat for about 4-5 minutes until softened, adding a splash of water if necessary.",
      "Stir in the curry powder, drained chickpeas and coconut milk. Bring to a gentle simmer.",
      "Simmer on low for about 10 minutes, stirring occasionally. Add the spinach and cook for another 1-2 minutes until wilted.",
      "Serve hot; add a little water during cooking if the sauce becomes too thick."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chickpea Salad with Lemon Dressing",
    "newName": "Chickpea Salad with Lemon Dressing",
    "expectedIngredients": [
      {
        "name": "Chickpeas",
        "amount": "1 can, rinsed"
      },
      {
        "name": "Cucumber",
        "amount": "1/2, diced"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Red onion",
        "amount": "2 tbsp"
      },
      {
        "name": "Tomatoes",
        "amount": "1, diced"
      }
    ],
    "expectedInstructions": [
      "Combine chickpeas and chopped veggies.",
      "Mix lemon juice and olive oil as dressing.",
      "Toss and season to taste."
    ],
    "instructions": [
      "Drain and rinse the canned chickpeas. Wash and dice the cucumber and tomato; finely chop the red onion.",
      "Combine the chickpeas and vegetables in a bowl.",
      "Whisk the lemon juice and olive oil with a fork.",
      "Toss the dressing through the salad and serve, or cover and refrigerate until needed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Cinnamon Chia Pudding",
    "newName": "Cinnamon Chia Pudding",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "2 tbsp"
      },
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Milk (or oat milk)",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Mix chia, milk, and cinnamon.",
      "Refrigerate 2+ hours.",
      "Stir and eat."
    ],
    "instructions": [
      "Stir the chia seeds, milk and cinnamon together in a covered jar or bowl.",
      "Leave in the fridge for about 15 minutes, then stir again to break up clumps.",
      "Keep covered in the fridge for at least 2 hours, or overnight, until thickened.",
      "Stir before serving. The chilling time is in addition to the hands-on preparation time."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Cottage Cheese and Pineapple Bowl",
    "newName": "Cottage Cheese and Pineapple Bowl",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Cottage cheese",
        "amount": "200 g"
      },
      {
        "name": "Pineapple",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Add cottage cheese to a bowl.",
      "Top with pineapple.",
      "Sprinkle chia seeds."
    ],
    "instructions": [
      "If using fresh pineapple, peel it, remove the hard core and cut the flesh into bite-sized pieces; drain canned pineapple if used.",
      "Spoon the cottage cheese into a bowl.",
      "Add the pineapple and sprinkle over the chia seeds.",
      "Serve promptly or keep refrigerated until serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Cucumber Feta Salad",
    "newName": "Cucumber Feta Salad",
    "expectedIngredients": [
      {
        "name": "Cucumber",
        "amount": "1"
      },
      {
        "name": "Feta",
        "amount": "60 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Dice cucumber.",
      "Crumble feta and combine.",
      "Dress with olive oil and lemon."
    ],
    "instructions": [
      "Wash the cucumber, trim the ends and cut it into bite-sized pieces.",
      "Put in a bowl and crumble in the feta.",
      "Mix the olive oil and lemon juice and pour over the salad.",
      "Toss gently and serve, or cover and refrigerate until needed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Cucumber Tuna Bites",
    "newName": "Cucumber Tuna Bites",
    "expectedIngredients": [
      {
        "name": "Cucumber",
        "amount": "1/2"
      },
      {
        "name": "Greek yogurt",
        "amount": "1 tbsp"
      },
      {
        "name": "Tuna",
        "amount": "1/2 can"
      }
    ],
    "expectedInstructions": [
      "Slice cucumber into rounds.",
      "Mix tuna with yogurt.",
      "Top cucumber rounds with tuna mix."
    ],
    "instructions": [
      "Wash the cucumber and cut it into thick rounds.",
      "Drain the canned tuna and flake it with a fork. Stir in the Greek yogurt.",
      "Spoon the tuna mixture onto the cucumber rounds.",
      "Serve straight away or keep the assembled bites refrigerated until serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Edamame with Sea Salt",
    "newName": "Edamame with Sea Salt",
    "expectedIngredients": [
      {
        "name": "Edamame",
        "amount": "1 cup"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Boil or steam edamame.",
      "Drain.",
      "Sprinkle salt and serve."
    ],
    "instructions": [
      "Bring a saucepan of water to a boil. Add frozen edamame without thawing, or follow its packet if the instructions differ.",
      "Simmer for about 4-5 minutes, or the packet time, until the beans are hot and tender.",
      "Drain, sprinkle with the salt and serve. If the edamame is in pods, eat the beans and discard the pods."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Egg Salad Lettuce Cups",
    "newName": "Egg Salad Lettuce Cups",
    "expectedIngredients": [
      {
        "name": "Boiled eggs",
        "amount": "2"
      },
      {
        "name": "Greek yogurt",
        "amount": "2 tbsp"
      },
      {
        "name": "Lettuce",
        "amount": "4 leaves"
      },
      {
        "name": "Mustard",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Mash eggs with yogurt and mustard.",
      "Spoon into lettuce leaves.",
      "Serve immediately."
    ],
    "instructions": [
      "Use hard-boiled eggs with firm yolks and whites; peel and chop them.",
      "Wash and dry the lettuce leaves.",
      "Mash the eggs with the yogurt and mustard, leaving small pieces for texture.",
      "Spoon into the lettuce leaves and serve, or keep the filling refrigerated until assembling."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Boiled eggs. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Garlic Lemon Chicken with Broccoli",
    "newName": "Garlic Lemon Chicken with Broccoli",
    "expectedIngredients": [
      {
        "name": "Broccoli",
        "amount": "2 cups"
      },
      {
        "name": "Chicken breast",
        "amount": "180 g"
      },
      {
        "name": "Garlic",
        "amount": "2 cloves"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Cook chicken in olive oil until done.",
      "Add garlic and broccoli, sauté until tender.",
      "Finish with lemon juice."
    ],
    "instructions": [
      "Use boneless chicken breast and cut it into roughly 2 cm pieces. Cut the broccoli into small florets and mince the garlic.",
      "Heat about half the olive oil in a frying pan over medium-high heat. Add the chicken and cook for about 6-8 minutes, turning regularly.",
      "Check the largest chicken pieces using the poultry cooking check below, then transfer them to a clean plate.",
      "Lower the heat to medium. Add the remaining oil and garlic; stir for about 30 seconds. Add the broccoli and 2 tablespoons of water, cover and cook for about 4-5 minutes until tender.",
      "Return the cooked chicken to the pan, add the lemon juice and stir until hot throughout. Serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Greek Yogurt Snack Cup",
    "newName": "Greek Yogurt Snack Cup",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Greek yogurt",
        "amount": "150 g"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Spoon yogurt into a cup.",
      "Add honey.",
      "Sprinkle chia seeds."
    ],
    "instructions": [
      "Spoon the chilled Greek yogurt into a cup or small bowl.",
      "Drizzle over the honey and scatter on the chia seeds.",
      "Serve immediately or keep covered in the fridge until needed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Greek Yogurt with Nuts and Honey",
    "newName": "Greek Yogurt with Nuts and Honey",
    "expectedIngredients": [
      {
        "name": "Cinnamon",
        "amount": "pinch"
      },
      {
        "name": "Greek yogurt",
        "amount": "200 g"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Mixed nuts",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Add yogurt to a bowl.",
      "Top with nuts and honey.",
      "Finish with cinnamon."
    ],
    "instructions": [
      "Spoon the Greek yogurt into a bowl.",
      "Roughly chop larger nuts if you prefer smaller pieces, then scatter them over the yogurt.",
      "Drizzle with the honey, add the cinnamon and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Hummus and Carrot Sticks",
    "newName": "Hummus and Carrot Sticks",
    "expectedIngredients": [
      {
        "name": "Carrots",
        "amount": "2"
      },
      {
        "name": "Hummus",
        "amount": "3 tbsp"
      }
    ],
    "expectedInstructions": [
      "Wash and cut carrots into sticks.",
      "Serve with hummus.",
      "Eat immediately."
    ],
    "instructions": [
      "Wash the carrots, trim their ends and peel if desired.",
      "Cut into sticks small enough to dip comfortably.",
      "Spoon the hummus into a bowl and serve with the carrot sticks; keep the hummus refrigerated until needed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Lentil Bolognese",
    "newName": "Lentil Bolognese",
    "expectedIngredients": [
      {
        "name": "Cooked lentils",
        "amount": "2 cups"
      },
      {
        "name": "Garlic",
        "amount": "1 clove"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Onion",
        "amount": "1/2"
      },
      {
        "name": "Tomato passata",
        "amount": "1.5 cups"
      }
    ],
    "expectedInstructions": [
      "Sauté onion and garlic in olive oil.",
      "Add lentils and passata, simmer 10–15 min.",
      "Serve with pasta or zucchini noodles."
    ],
    "instructions": [
      "Use cooked or canned lentils, not dried lentils. Drain them; finely dice the onion and mince the garlic.",
      "Heat the olive oil in a saucepan over medium heat. Add the onion and stir for about 4-5 minutes until softened.",
      "Stir in the garlic for about 30 seconds, then add the lentils and passata.",
      "Simmer over low heat for about 10-15 minutes, stirring, until hot throughout and slightly thickened. Add water a little at a time if needed.",
      "Serve the lentil sauce as prepared; pasta or other accompaniments are separate ingredients and are not included in this recipe."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked lentils. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use ready-cooked or canned lentils, drained; the quantity is cooked lentils."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Lentil Soup (Quick)",
    "newName": "Lentil Soup (Quick)",
    "expectedIngredients": [
      {
        "name": "Carrot",
        "amount": "1, diced"
      },
      {
        "name": "Cooked lentils",
        "amount": "2 cups"
      },
      {
        "name": "Garlic",
        "amount": "1 clove"
      },
      {
        "name": "Onion",
        "amount": "1/2, diced"
      },
      {
        "name": "Vegetable stock",
        "amount": "3 cups"
      }
    ],
    "expectedInstructions": [
      "Sauté onion, carrot, and garlic.",
      "Add lentils and stock.",
      "Simmer 10–15 minutes."
    ],
    "instructions": [
      "Use cooked or canned lentils and drain them. Dice the onion and carrot and mince the garlic.",
      "Put the onion, carrot and garlic in a saucepan with 2 tablespoons of water. Cook over medium heat for about 4-5 minutes, stirring and adding water if needed to prevent sticking.",
      "Add the lentils and vegetable stock; bring to a gentle simmer.",
      "Simmer on low for about 10-15 minutes until the carrot is tender and the soup is hot throughout, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked lentils. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use ready-cooked or canned lentils, drained; the quantity is cooked lentils."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Mackerel Potato Plate",
    "newName": "Mackerel Potato Plate",
    "expectedIngredients": [
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Mackerel (canned)",
        "amount": "1 can"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Potatoes",
        "amount": "2 small, boiled"
      }
    ],
    "expectedInstructions": [
      "Boil potatoes until soft.",
      "Plate with mackerel.",
      "Add olive oil and lemon."
    ],
    "instructions": [
      "The ingredient quantity refers to potatoes that are already boiled. If starting with raw potatoes, cut them into even pieces and simmer in water until a fork slides through easily, about 12-18 minutes; drain.",
      "Drain the canned mackerel and check for any bones you do not want to eat.",
      "Arrange the boiled potatoes and mackerel on a plate.",
      "Drizzle with the olive oil and lemon juice and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Mediterranean Pasta Salad",
    "newName": "Mediterranean Pasta Salad",
    "expectedIngredients": [
      {
        "name": "Cooked pasta",
        "amount": "1.5 cups"
      },
      {
        "name": "Feta",
        "amount": "40 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Olives",
        "amount": "2 tbsp"
      },
      {
        "name": "Tomatoes",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Combine pasta with olives, tomatoes, and feta.",
      "Add olive oil.",
      "Toss and chill."
    ],
    "instructions": [
      "Use pasta that has already been cooked according to its packet and safely cooled; the measured amount is cooked pasta.",
      "Wash and chop the tomatoes; slice the olives if desired and crumble the feta.",
      "Combine the pasta, tomatoes, olives and feta in a bowl.",
      "Toss with the olive oil and serve, or cover and refrigerate promptly until serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked pasta. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Oat Banana Pancakes (2-Ingredient)",
    "newName": "Oat Banana Pancakes",
    "expectedIngredients": [
      {
        "name": "Banana",
        "amount": "1"
      },
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Oats",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Mash banana and whisk in eggs and oats.",
      "Cook small pancakes in a non-stick pan.",
      "Flip once and serve."
    ],
    "instructions": [
      "Mash the peeled banana in a bowl, then beat in the eggs and oats. Let the mixture stand for about 5 minutes so the oats soften.",
      "Warm a good non-stick frying pan over low-medium heat. Spoon in small pancakes, about 2 tablespoons of batter each, with room to turn them.",
      "Cook for about 2-3 minutes until the edges are set and the underside is lightly golden. Turn carefully with a spatula.",
      "Cook the other side for about 1-2 minutes, until the centre is set with no wet batter; use the egg-dish cooking check below.",
      "Repeat with the remaining batter, lowering the heat if the outside browns before the centre sets, and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Oats with Cocoa and Banana",
    "newName": "Oats with Cocoa and Banana",
    "expectedIngredients": [
      {
        "name": "Banana",
        "amount": "1/2"
      },
      {
        "name": "Cocoa powder",
        "amount": "1 tsp"
      },
      {
        "name": "Milk or water",
        "amount": "1 cup"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Cook oats with milk/water.",
      "Stir in cocoa powder.",
      "Top with banana."
    ],
    "instructions": [
      "Bring the milk or water to a gentle boil in a small saucepan.",
      "Stir in the rolled oats, reduce to medium-low and cook for about 5 minutes, stirring regularly, until creamy.",
      "Mix the cocoa with a spoonful of hot porridge to make a smooth paste, then stir it back into the saucepan.",
      "Spoon into a bowl and top with sliced banana."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.quakeroats.com/products/hot-cereals/old-fashioned-oats"
      ]
    }
  },
  {
    "name": "One-Pan Paprika Chicken",
    "newName": "One-Pan Paprika Chicken",
    "expectedIngredients": [
      {
        "name": "Bell pepper",
        "amount": "1/2"
      },
      {
        "name": "Chicken thighs",
        "amount": "2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Onion",
        "amount": "1/2"
      },
      {
        "name": "Paprika",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Season chicken with paprika and salt.",
      "Cook chicken then add onion and pepper.",
      "Cook until veggies soften."
    ],
    "instructions": [
      "Use boneless chicken thighs; if yours contain bones, remove them before following these pan timings. Cut into roughly 2 cm pieces.",
      "Dice the onion and bell pepper. Toss the chicken with the paprika; no extra salt is required by the ingredient list.",
      "Heat the olive oil in a frying pan over medium-high heat. Cook the chicken for about 6-8 minutes, turning regularly.",
      "Check the largest pieces using the poultry cooking check below, then transfer to a clean plate.",
      "Cook the onion and pepper in the same pan over medium heat for about 5-7 minutes until tender. Return the cooked chicken and stir until hot throughout, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Overnight Oats with Chia and Berries",
    "newName": "Overnight Oats with Chia and Berries",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "1 tbsp"
      },
      {
        "name": "Greek yogurt",
        "amount": "2 tbsp"
      },
      {
        "name": "Milk (or oat milk)",
        "amount": "3/4 cup"
      },
      {
        "name": "Mixed berries",
        "amount": "1/2 cup"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Mix oats, chia, milk, and yogurt in a jar.",
      "Refrigerate overnight.",
      "Top with berries before serving."
    ],
    "instructions": [
      "Stir the rolled oats, chia seeds, milk and Greek yogurt together in a covered jar or bowl.",
      "Refrigerate for at least 8 hours or overnight; stir again after about 15 minutes if convenient to disperse chia clumps.",
      "Wash fresh berries or prepare frozen berries according to their packet.",
      "Stir the oats before eating, add the berries and serve chilled. Overnight chilling is additional to the hands-on preparation time."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Pea Soup (Quick)",
    "newName": "Pea Soup (Quick)",
    "expectedIngredients": [
      {
        "name": "Frozen peas",
        "amount": "2 cups"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Onion",
        "amount": "1/2"
      },
      {
        "name": "Vegetable stock",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Sauté onion in olive oil.",
      "Add peas and stock, simmer 8–10 min.",
      "Blend until smooth."
    ],
    "instructions": [
      "Finely dice the onion. Heat the olive oil in a saucepan over medium heat.",
      "Add the onion and stir for about 4-5 minutes until softened.",
      "Add the frozen peas and stock, bring to a gentle simmer and cook for about 8-10 minutes until tender.",
      "Take off the heat. Blend carefully using a stick blender, keeping its head under the liquid; if using a jug blender, follow its hot-liquid instructions.",
      "Return to the saucepan if needed, heat until hot throughout and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Peanut Butter Banana Oat Bowl",
    "newName": "Peanut Butter Banana Oat Bowl",
    "expectedIngredients": [
      {
        "name": "Banana",
        "amount": "1"
      },
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Peanut butter",
        "amount": "1 tbsp"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      },
      {
        "name": "Water or milk",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Cook oats with water/milk until creamy.",
      "Slice banana and stir in cinnamon.",
      "Top with peanut butter and banana."
    ],
    "instructions": [
      "Bring the milk or water to a gentle boil in a saucepan. Stir in the rolled oats.",
      "Reduce to medium-low and cook for about 5 minutes, stirring occasionally, until creamy.",
      "Peel and slice the banana. Stir the cinnamon into the cooked oats.",
      "Spoon into a bowl and top with the peanut butter and banana."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.quakeroats.com/products/hot-cereals/old-fashioned-oats"
      ]
    }
  },
  {
    "name": "Quinoa Chicken Salad",
    "newName": "Quinoa Chicken Salad",
    "expectedIngredients": [
      {
        "name": "Cooked chicken",
        "amount": "120 g"
      },
      {
        "name": "Cooked quinoa",
        "amount": "1 cup"
      },
      {
        "name": "Cucumber",
        "amount": "1/2"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Combine quinoa, chicken, and chopped cucumber.",
      "Mix lemon and olive oil.",
      "Toss and season."
    ],
    "instructions": [
      "Use quinoa and chicken that have already been fully cooked and safely chilled; measure the quinoa after cooking.",
      "Wash and dice the cucumber. Cut or shred the cooked chicken.",
      "Combine the quinoa, chicken and cucumber in a bowl.",
      "Whisk the lemon juice and olive oil, toss through the salad and serve promptly or refrigerate."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked chicken, Cooked quinoa. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Chickpeas (Quick)",
    "newName": "Roasted Chickpeas (Quick)",
    "expectedIngredients": [
      {
        "name": "Chickpeas",
        "amount": "1 can"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Paprika",
        "amount": "1 tsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Rinse and dry chickpeas.",
      "Toss with olive oil, paprika, and salt.",
      "Bake at 200°C until crisp."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Drain and rinse canned chickpeas, then pat them very dry with a clean towel.",
      "Toss with the olive oil, paprika and salt.",
      "Spread in a single layer on a baking tray. Roast for about 25-30 minutes, shaking the tray halfway through, until dry on the outside and crisp.",
      "Allow to cool briefly before eating. Keep watching near the end so the chickpeas do not scorch."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Veggie Couscous",
    "newName": "Roasted Veggie Couscous",
    "expectedIngredients": [
      {
        "name": "Bell pepper",
        "amount": "1/2"
      },
      {
        "name": "Cooked couscous",
        "amount": "1 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Zucchini",
        "amount": "1/2"
      }
    ],
    "expectedInstructions": [
      "Roast chopped veggies with olive oil.",
      "Mix into couscous.",
      "Season and serve."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Cut the zucchini and bell pepper into roughly 2 cm pieces.",
      "Toss the vegetables with the olive oil and salt and spread in one layer on a baking tray.",
      "Roast for about 25-30 minutes, turning once, until tender with browned edges.",
      "Use couscous already cooked according to its packet; the listed quantity is measured after cooking. If chilled, reheat it until steaming hot throughout.",
      "Fold the roasted vegetables into the couscous and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked couscous. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.bbcgoodfoodme.com/recipes/roasted-vegetables/"
      ]
    }
  },
  {
    "name": "Salmon Rice Bowl",
    "newName": "Salmon Rice Bowl",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Cooked rice",
        "amount": "1 cup"
      },
      {
        "name": "Cooked salmon",
        "amount": "120 g"
      },
      {
        "name": "Cucumber",
        "amount": "1/3"
      },
      {
        "name": "Soy sauce",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Add rice to bowl.",
      "Top with salmon and sliced veggies.",
      "Drizzle soy sauce."
    ],
    "instructions": [
      "Use salmon and rice that have already been fully cooked; these directions do not cook raw salmon.",
      "Wash and slice the cucumber. Halve and stone the avocado, then slice the flesh.",
      "If serving warm, reheat the cooked rice and salmon until steaming hot throughout using the reheating check below; otherwise use safely chilled cooked ingredients.",
      "Put the rice in a bowl, flake the salmon over it and add the cucumber and avocado.",
      "Drizzle over the soy sauce and serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked salmon, Cooked rice. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Sardine Rice Bowl",
    "newName": "Sardine Rice Bowl",
    "expectedIngredients": [
      {
        "name": "Cooked rice",
        "amount": "1 cup"
      },
      {
        "name": "Cucumber",
        "amount": "1/3"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Sardines",
        "amount": "1 can"
      }
    ],
    "expectedInstructions": [
      "Add rice to bowl.",
      "Top with sardines and cucumber.",
      "Finish with lemon juice."
    ],
    "instructions": [
      "Drain the canned sardines. Wash and slice the cucumber.",
      "Use rice already cooked according to its packet; if chilled rice is being served warm, reheat it until steaming hot throughout.",
      "Spoon the rice into a bowl and add the sardines and cucumber.",
      "Finish with the lemon juice and serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked rice. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Sardine Toast with Lemon",
    "newName": "Sardine Toast with Lemon",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Sardines",
        "amount": "1 can"
      },
      {
        "name": "Wholegrain bread",
        "amount": "2 slices"
      }
    ],
    "expectedInstructions": [
      "Toast the bread.",
      "Top with sardines.",
      "Add lemon juice and pepper."
    ],
    "instructions": [
      "Drain the canned sardines and check for any bones you do not want to eat.",
      "Toast the wholegrain bread until crisp, about 2-3 minutes depending on the toaster.",
      "Arrange the sardines on the toast, add the lemon juice and black pepper and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Shrimp Zucchini Noodles",
    "newName": "Shrimp Zucchini Noodles",
    "expectedIngredients": [
      {
        "name": "Garlic",
        "amount": "1 clove"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Shrimp",
        "amount": "200 g"
      },
      {
        "name": "Zucchini noodles",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Cook shrimp in olive oil with garlic.",
      "Add zucchini noodles and toss briefly.",
      "Finish with lemon juice."
    ],
    "instructions": [
      "Use peeled, deveined, fully thawed shrimp. Pat dry and mince the garlic.",
      "Heat the olive oil in a frying pan over medium heat. Add the garlic and stir for about 30 seconds without letting it burn.",
      "Add the shrimp in a single layer and cook for about 2-3 minutes per side, until opaque throughout; use the shrimp cooking check below.",
      "Add the zucchini noodles and toss for about 1-2 minutes until just tender, then finish with the lemon juice.",
      "Serve immediately so the zucchini retains some texture."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use peeled, deveined, fully thawed shrimp for the stated timings."
      ],
      "cookingChecks": [
        "shrimp",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Simple Tomato Lentil Stew",
    "newName": "Simple Tomato Lentil Stew",
    "expectedIngredients": [
      {
        "name": "Cooked lentils",
        "amount": "2 cups"
      },
      {
        "name": "Garlic",
        "amount": "1 clove"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Tomato passata",
        "amount": "1.5 cups"
      }
    ],
    "expectedInstructions": [
      "Sauté garlic in olive oil.",
      "Add lentils and passata, simmer 10–15 min.",
      "Serve warm."
    ],
    "instructions": [
      "Use cooked or canned lentils and drain them; mince the garlic.",
      "Heat the olive oil in a saucepan over medium heat. Stir in the garlic for about 30 seconds.",
      "Add the lentils and passata and bring to a gentle simmer.",
      "Simmer on low for about 10-15 minutes, stirring occasionally, until hot throughout. Add a little water if the sauce becomes too thick, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked lentils. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use ready-cooked or canned lentils, drained; the quantity is cooked lentils."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Smoked Salmon Cucumber Toast",
    "newName": "Smoked Salmon Cucumber Toast",
    "expectedIngredients": [
      {
        "name": "Cream cheese",
        "amount": "1 tbsp"
      },
      {
        "name": "Cucumber",
        "amount": "6 slices"
      },
      {
        "name": "Lemon",
        "amount": "wedge"
      },
      {
        "name": "Smoked salmon",
        "amount": "60 g"
      },
      {
        "name": "Wholegrain bread",
        "amount": "2 slices"
      }
    ],
    "expectedInstructions": [
      "Toast bread and spread cream cheese.",
      "Add salmon and cucumber.",
      "Squeeze lemon and serve."
    ],
    "instructions": [
      "Use ready-to-eat smoked salmon, following its pack instructions. Wash and slice the cucumber.",
      "Toast the bread until crisp, about 2-3 minutes depending on the toaster.",
      "Spread the cream cheese over the toast and add the smoked salmon and cucumber.",
      "Squeeze over the lemon wedge and serve promptly."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use ready-to-eat cooked/deli or smoked products as specified and follow their pack directions and use-by date; do not substitute raw meat or raw fish into an assembly-only method."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Spinach and Feta Scramble",
    "newName": "Spinach and Feta Scramble",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Feta",
        "amount": "30 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Spinach",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Heat olive oil in a pan on medium heat.",
      "Add spinach and cook until wilted.",
      "Add beaten eggs, scramble, then finish with feta."
    ],
    "instructions": [
      "Beat the eggs with the salt in a bowl. Wash and dry the spinach and crumble the feta.",
      "Heat the olive oil in a non-stick frying pan over medium heat. Add the spinach and stir for about 1-2 minutes until wilted.",
      "Reduce to low-medium and pour in the eggs. Stir gently with a spatula for about 2-4 minutes, folding the set egg into the liquid egg.",
      "Cook until the egg is set with no runny parts, using the egg-dish check below. Fold in the feta and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Tofu Stir-Fry Bowl",
    "newName": "Tofu Stir-Fry Bowl",
    "expectedIngredients": [
      {
        "name": "Broccoli",
        "amount": "1 cup"
      },
      {
        "name": "Carrot",
        "amount": "1/2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Soy sauce",
        "amount": "1 tbsp"
      },
      {
        "name": "Tofu",
        "amount": "200 g"
      }
    ],
    "expectedInstructions": [
      "Sauté tofu until lightly browned.",
      "Add veggies and cook until tender.",
      "Add soy sauce and serve."
    ],
    "instructions": [
      "Drain firm tofu, pat it dry and cut into about 2 cm cubes. Slice the carrot thinly and cut the broccoli into small florets.",
      "Heat the olive oil in a non-stick frying pan over medium-high heat. Add the tofu and turn for about 6-8 minutes until lightly browned.",
      "Add the carrot, broccoli and 2 tablespoons of water. Cover and cook over medium heat for about 4-5 minutes, until the vegetables are tender.",
      "Uncover, add the soy sauce and toss for another minute until hot throughout, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use firm tofu, drained and patted dry, so it holds its shape when cooked."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Tomato Basil Egg Muffins",
    "newName": "Tomato Basil Egg Muffins",
    "expectedIngredients": [
      {
        "name": "Basil",
        "amount": "2 tbsp"
      },
      {
        "name": "Cherry tomatoes",
        "amount": "1/2 cup"
      },
      {
        "name": "Eggs",
        "amount": "4"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Whisk eggs and mix in tomatoes and basil.",
      "Pour into muffin cups.",
      "Bake at 180°C for ~15 minutes."
    ],
    "instructions": [
      "Preheat a conventional oven to 180°C. Use a silicone muffin mould or paper muffin liners so extra oil is not required.",
      "Wash and chop the cherry tomatoes and basil. Beat the eggs with the salt, then stir in the tomatoes and basil.",
      "Divide the mixture among the muffin cups, filling each no more than three-quarters full.",
      "Bake for about 15-20 minutes until the centres are set with no liquid egg; use the egg-dish cooking check below.",
      "Leave in the mould for about 5 minutes, then remove carefully and serve, or cool and refrigerate promptly."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Tomato Basil White Bean Stew",
    "newName": "Tomato Basil White Bean Stew",
    "expectedIngredients": [
      {
        "name": "Basil",
        "amount": "2 tbsp"
      },
      {
        "name": "Garlic",
        "amount": "1 clove"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Tomato passata",
        "amount": "1 cup"
      },
      {
        "name": "White beans",
        "amount": "1 can"
      }
    ],
    "expectedInstructions": [
      "Sauté garlic in olive oil.",
      "Add passata and beans, simmer 10 min.",
      "Stir in basil and serve."
    ],
    "instructions": [
      "Drain and rinse canned white beans; mince the garlic and chop the basil.",
      "Heat the olive oil in a saucepan over medium heat and stir the garlic for about 30 seconds.",
      "Add the passata and beans, bring to a gentle simmer and cook on low for about 10 minutes, stirring occasionally.",
      "Stir in the basil, heat for another minute and serve hot."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Tomato Egg Stir Fry",
    "newName": "Tomato Egg Stir Fry",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "3"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Tomatoes",
        "amount": "2"
      }
    ],
    "expectedInstructions": [
      "Scramble eggs lightly and set aside.",
      "Cook tomatoes until saucy.",
      "Return eggs, stir and serve."
    ],
    "instructions": [
      "Wash and chop the tomatoes. Beat the eggs with the salt.",
      "Heat about half the olive oil in a non-stick frying pan over medium heat. Add the eggs and stir for about 2-3 minutes until set, then transfer to a clean plate.",
      "Add the remaining oil and tomatoes to the pan. Cook for about 4-5 minutes, stirring, until the tomatoes soften into a sauce.",
      "Return the eggs and stir for another minute until hot throughout, checking there are no runny egg parts; use the egg-dish check below.",
      "Serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Tomato Mozzarella Snack Plate",
    "newName": "Tomato Mozzarella Snack Plate",
    "expectedIngredients": [
      {
        "name": "Mozzarella",
        "amount": "60 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Tomatoes",
        "amount": "1"
      }
    ],
    "expectedInstructions": [
      "Slice tomato and mozzarella.",
      "Arrange on a plate.",
      "Drizzle olive oil."
    ],
    "instructions": [
      "Wash the tomato and cut it into slices. Slice the mozzarella.",
      "Arrange alternating slices on a plate.",
      "Drizzle over the olive oil and serve promptly, keeping mozzarella refrigerated until preparation."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Trail Mix Cup",
    "newName": "Trail Mix Cup",
    "expectedIngredients": [
      {
        "name": "Dried fruit",
        "amount": "1 tbsp"
      },
      {
        "name": "Mixed nuts",
        "amount": "2 tbsp"
      },
      {
        "name": "Pumpkin seeds",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Measure ingredients into a cup.",
      "Mix.",
      "Snack."
    ],
    "instructions": [
      "Measure the nuts, pumpkin seeds and dried fruit into a small bowl.",
      "Mix thoroughly. Chop large dried-fruit pieces if you prefer bite-sized pieces.",
      "Serve the measured portion or keep it in a closed container until needed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Tuna and White Bean Bowl",
    "newName": "Tuna and White Bean Bowl",
    "expectedIngredients": [
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Parsley",
        "amount": "1 tbsp"
      },
      {
        "name": "Tuna",
        "amount": "1 can"
      },
      {
        "name": "White beans",
        "amount": "1/2 can"
      }
    ],
    "expectedInstructions": [
      "Drain tuna and beans.",
      "Mix with parsley, lemon, and olive oil.",
      "Serve as a bowl or with bread."
    ],
    "instructions": [
      "Drain canned tuna and white beans; rinse the beans and chop the parsley.",
      "Flake the tuna into a bowl and gently fold in the beans.",
      "Add the lemon juice, olive oil and parsley and mix without crushing the beans.",
      "Serve as a bowl, or keep covered and refrigerated until serving. Bread is not included in the ingredients."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turkey Hummus Wrap",
    "newName": "Turkey Hummus Wrap",
    "expectedIngredients": [
      {
        "name": "Cucumber",
        "amount": "1/4 sliced"
      },
      {
        "name": "Hummus",
        "amount": "2 tbsp"
      },
      {
        "name": "Lettuce",
        "amount": "1 cup"
      },
      {
        "name": "Turkey slices",
        "amount": "80 g"
      },
      {
        "name": "Wholegrain wrap",
        "amount": "1"
      }
    ],
    "expectedInstructions": [
      "Spread hummus on wrap.",
      "Add turkey and veggies.",
      "Roll and slice."
    ],
    "instructions": [
      "Use ready-to-eat cooked turkey slices, not raw turkey. Wash and dry the lettuce and slice the cucumber.",
      "Spread the hummus across the wrap, leaving a small border around the edge.",
      "Layer the turkey, lettuce and cucumber in the centre.",
      "Fold the sides in, roll firmly from the bottom and slice in half. Serve promptly or keep covered and refrigerated."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use ready-to-eat cooked/deli or smoked products as specified and follow their pack directions and use-by date; do not substitute raw meat or raw fish into an assembly-only method."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turkey Meatballs with Tomato Sauce",
    "newName": "Turkey Meatballs with Tomato Sauce",
    "expectedIngredients": [
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Garlic",
        "amount": "1 clove"
      },
      {
        "name": "Ground turkey",
        "amount": "250 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Tomato passata",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Mix turkey and egg, shape into meatballs.",
      "Brown meatballs in olive oil.",
      "Simmer in passata with garlic."
    ],
    "instructions": [
      "Use thawed ground turkey. Mince the garlic and beat the egg, then mix the egg through the turkey.",
      "With clean hands, form small meatballs about 3 cm wide; wash your hands after handling the raw mixture.",
      "Heat the olive oil in a non-stick frying pan over medium heat. Turn the meatballs for about 5-6 minutes until browned on the outside.",
      "Add the garlic and passata, plus a splash of water if needed to cover the base of the pan. Bring to a gentle simmer, cover and cook for about 12-15 minutes, turning once.",
      "Check the largest meatball using the poultry cooking check below; browning alone is not a doneness check. Continue simmering if needed and serve only once cooked through."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Veggie Fried Rice (Egg)",
    "newName": "Veggie Fried Rice (Egg)",
    "expectedIngredients": [
      {
        "name": "Cooked rice",
        "amount": "2 cups"
      },
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Mixed veggies",
        "amount": "1.5 cups"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Soy sauce",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Sauté veggies in olive oil.",
      "Add rice and soy sauce, stir-fry.",
      "Push aside and scramble eggs, then mix."
    ],
    "instructions": [
      "Use cooked rice that has been safely chilled; break up clumps with a fork. Beat the eggs in a bowl.",
      "Heat the olive oil in a large non-stick frying pan over medium-high heat. Add the mixed vegetables and cook for about 4-6 minutes until tender; follow the packet for frozen vegetables.",
      "Push the vegetables aside, add the eggs and scramble for about 2-3 minutes until set.",
      "Add the rice and soy sauce. Stir-fry for about 3-5 minutes, breaking up clumps, until the whole dish is steaming hot throughout.",
      "Use the reheating and egg-dish cooking checks below, then serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked rice. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "egg-dish",
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Veggie Omelette",
    "newName": "Veggie Omelette",
    "expectedIngredients": [
      {
        "name": "Bell pepper",
        "amount": "1/4 cup"
      },
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Mushrooms",
        "amount": "1/2 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Onion",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Sauté veggies in olive oil until soft.",
      "Pour in beaten eggs.",
      "Cook until set and fold."
    ],
    "instructions": [
      "Finely chop the onion, mushrooms and bell pepper. Beat the eggs in a bowl.",
      "Heat the olive oil in a non-stick frying pan over medium heat. Add the vegetables and stir for about 4-5 minutes until softened.",
      "Reduce to low-medium and pour in the eggs. Tilt the pan to spread them around the vegetables.",
      "Cook for about 3-5 minutes until the underside is set and there is no liquid egg on top; cover briefly if needed. Use the egg-dish check below.",
      "Fold in half with a spatula and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Warm Quinoa Breakfast Bowl",
    "newName": "Warm Quinoa Breakfast Bowl",
    "expectedIngredients": [
      {
        "name": "Almonds",
        "amount": "1 tbsp"
      },
      {
        "name": "Blueberries",
        "amount": "1/2 cup"
      },
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Cooked quinoa",
        "amount": "1 cup"
      },
      {
        "name": "Milk (or oat milk)",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Warm quinoa with milk in a small pot.",
      "Stir in cinnamon.",
      "Top with blueberries and almonds."
    ],
    "instructions": [
      "Use quinoa that has already been cooked according to its packet; the quantity is measured after cooking.",
      "Combine the quinoa, milk and cinnamon in a small saucepan.",
      "Warm over low-medium heat for about 3-5 minutes, stirring, until hot throughout. Use the reheating guidance below if the quinoa was chilled.",
      "Spoon into a bowl and top with washed blueberries and the almonds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked quinoa. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Anti-Inflammatory Golden Milk Smoothie Bowl",
    "newName": "Golden Milk Smoothie Bowl",
    "expectedIngredients": [
      {
        "name": "Blueberries",
        "amount": "2 tbsp"
      },
      {
        "name": "Chia seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Coconut milk",
        "amount": "3/4 cup"
      },
      {
        "name": "Frozen banana",
        "amount": "1"
      },
      {
        "name": "Mango, diced",
        "amount": "2 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Blend frozen banana, coconut milk, turmeric, and cinnamon until thick and smooth.",
      "Pour into a bowl.",
      "Arrange diced mango, blueberries, and chia seeds in rows on top."
    ],
    "instructions": [
      "Blend frozen banana, coconut milk, turmeric, and cinnamon until thick and smooth.",
      "Pour into a bowl.",
      "Arrange diced mango, blueberries, and chia seeds in rows on top."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Follow frozen fruit packet instructions; some berries must be heated and cooled before being eaten."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Apple Slices with Almond Butter and Cinnamon",
    "newName": "Apple Slices with Almond Butter and Cinnamon",
    "expectedIngredients": [
      {
        "name": "Almond butter",
        "amount": "2 tbsp"
      },
      {
        "name": "Apple, sliced",
        "amount": "1"
      },
      {
        "name": "Cinnamon",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Slice the apple and arrange in a fan on a plate.",
      "Serve with almond butter for dipping.",
      "Dust lightly with cinnamon."
    ],
    "instructions": [
      "Slice the apple and arrange in a fan on a plate.",
      "Serve with almond butter for dipping.",
      "Dust lightly with cinnamon."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Apple Slices with Almond Butter, Cinnamon, and Cheddar (Non-Vegan Alt)",
    "newName": "Apple Slices with Almond Butter, Cinnamon, and Cheddar (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Almond butter",
        "amount": "2 tbsp"
      },
      {
        "name": "Apple, sliced",
        "amount": "1"
      },
      {
        "name": "Cheddar cheese, sliced",
        "amount": "30 g"
      },
      {
        "name": "Cinnamon",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Slice the apple and cheddar.",
      "Arrange both on a plate alongside almond butter for dipping.",
      "Dust lightly with cinnamon."
    ],
    "instructions": [
      "Slice the apple and cheddar.",
      "Arrange both on a plate alongside almond butter for dipping.",
      "Dust lightly with cinnamon."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Apple Slices with Greek Yogurt and Cinnamon",
    "newName": "Apple Slices with Greek Yogurt and Cinnamon",
    "expectedIngredients": [
      {
        "name": "Apple, sliced",
        "amount": "1"
      },
      {
        "name": "Cinnamon",
        "amount": "pinch"
      },
      {
        "name": "Greek yogurt",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Slice the apple.",
      "Spoon Greek yogurt into a small bowl and dust with cinnamon.",
      "Serve apple slices alongside the yogurt for dipping."
    ],
    "instructions": [
      "Slice the apple.",
      "Spoon Greek yogurt into a small bowl and dust with cinnamon.",
      "Serve apple slices alongside the yogurt for dipping."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Avocado Toast on Whole Grain with Hemp Seeds",
    "newName": "Avocado Toast on Whole Grain with Hemp Seeds",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "6"
      },
      {
        "name": "Chili flakes",
        "amount": "pinch"
      },
      {
        "name": "Hemp seeds",
        "amount": "1 tbsp"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Whole grain bread",
        "amount": "2 slices"
      }
    ],
    "expectedInstructions": [
      "Toast the bread.",
      "Mash avocado with lemon juice and salt.",
      "Spread avocado mixture onto the toast.",
      "Top with halved cherry tomatoes, hemp seeds, and a pinch of chili flakes."
    ],
    "instructions": [
      "Toast the bread.",
      "Mash avocado with lemon juice and salt.",
      "Spread avocado mixture onto the toast.",
      "Top with halved cherry tomatoes, hemp seeds, and a pinch of chili flakes."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Avocado Toast with Fried Egg and Feta (Non-Vegan Alt)",
    "newName": "Avocado Toast with Fried Egg and Feta (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "6"
      },
      {
        "name": "Chili flakes",
        "amount": "pinch"
      },
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Feta, crumbled",
        "amount": "20 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Whole grain bread",
        "amount": "1 slice"
      }
    ],
    "expectedInstructions": [
      "Toast the bread.",
      "Mash avocado with lemon juice and spread onto the toast.",
      "Fry the egg to your preference.",
      "Top toast with the fried egg and crumbled feta.",
      "Finish with halved cherry tomatoes and chili flakes."
    ],
    "instructions": [
      "Toast the bread.",
      "Mash avocado with lemon juice and spread onto the toast.",
      "Fry the egg to your preference.",
      "Top toast with the fried egg and crumbled feta.",
      "Finish with halved cherry tomatoes and chili flakes."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "whole-egg",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Baked Cod with Roasted Cauliflower, Olive Oil, and Turmeric",
    "newName": "Baked Cod with Roasted Cauliflower, Olive Oil, and Turmeric",
    "expectedIngredients": [
      {
        "name": "Cauliflower florets",
        "amount": "1 cup"
      },
      {
        "name": "Cod fillet",
        "amount": "150 g"
      },
      {
        "name": "Lemon",
        "amount": "1/2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Parsley, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Toss cauliflower florets with olive oil and turmeric, spread on a baking sheet, and roast for 15 minutes.",
      "Place cod fillet on a separate sheet with a squeeze of lemon and bake for 12-15 minutes until cooked through.",
      "Plate the cod with the roasted cauliflower and finish with parsley."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Cut the cauliflower into small, evenly sized florets.",
      "Toss the cauliflower with most of the olive oil and the turmeric; roast in one layer for about 15 minutes.",
      "Place fresh or thawed cod on a separate tray with the remaining oil and a squeeze of lemon. Bake for about 12-15 minutes while the cauliflower continues to roast until tender.",
      "Check the thickest part of the cod using the fish cooking check below, then plate with the cauliflower and parsley."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Baked Halibut with Roasted Fennel and Olives",
    "newName": "Baked Halibut with Roasted Fennel and Olives",
    "expectedIngredients": [
      {
        "name": "Fennel, sliced",
        "amount": "1 cup"
      },
      {
        "name": "Halibut fillet",
        "amount": "150 g"
      },
      {
        "name": "Lemon, sliced",
        "amount": "1/2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Olives",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Toss sliced fennel with olive oil and roast for 15 minutes, until softened.",
      "Add halibut fillet and lemon slices to the sheet, and bake for 12-15 minutes until cooked through.",
      "Scatter olives over the top before serving."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Slice the fennel thinly so it cooks evenly.",
      "Toss the fennel with the olive oil and roast in a baking dish for about 15 minutes until starting to soften.",
      "Place the fresh or thawed halibut over the fennel with the lemon slices. Bake for about 12-15 minutes more, until the fennel is tender.",
      "Check the fish in its thickest part using the fish cooking check below. Scatter over the olives and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Baked Salmon with Roasted Brussels Sprouts and Sweet Potato",
    "newName": "Baked Salmon with Roasted Brussels Sprouts and Sweet Potato",
    "expectedIngredients": [
      {
        "name": "Brussels sprouts, halved",
        "amount": "1 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tbsp"
      },
      {
        "name": "Salmon fillet",
        "amount": "150 g"
      },
      {
        "name": "Sweet potato, diced",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Toss Brussels sprouts and sweet potato with olive oil, spread on a baking sheet, and roast for 15 minutes.",
      "Add the salmon fillet to the sheet and roast for another 12-15 minutes, until the salmon is cooked through.",
      "Scatter pomegranate seeds over the plate before serving."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Cut the sweet potato into about 2 cm cubes and halve the Brussels sprouts.",
      "Toss the vegetables with most of the olive oil and roast in one layer for about 15-20 minutes.",
      "Add fresh or thawed salmon in a small baking dish with the remaining oil. Bake for about 12-15 minutes more, turning the vegetables once, until the potato is fork-tender.",
      "Check the salmon using the fish cooking check below and serve with the roasted vegetables and pomegranate seeds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Baked Trout with Steamed Kale, Quinoa, and Roasted Beets",
    "newName": "Baked Trout with Steamed Kale, Quinoa, and Roasted Beets",
    "expectedIngredients": [
      {
        "name": "Beets, roasted and sliced",
        "amount": "1/2 cup"
      },
      {
        "name": "Cooked quinoa",
        "amount": "3/4 cup"
      },
      {
        "name": "Kale, chopped",
        "amount": "2 cups"
      },
      {
        "name": "Lemon",
        "amount": "1/2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Trout fillet",
        "amount": "150 g"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F and roast beets separately until tender, about 35-40 minutes (or use pre-cooked beets).",
      "Bake trout with olive oil and a squeeze of lemon for 12-15 minutes, until cooked through.",
      "Steam kale for 3-4 minutes until wilted.",
      "Serve the trout over quinoa with steamed kale and roasted beets on the side."
    ],
    "instructions": [
      "This recipe uses quinoa and beets that are already cooked; prepare them separately before starting if necessary.",
      "Preheat a conventional oven to 200°C. Place fresh or thawed trout in a baking dish with the olive oil and a squeeze of lemon.",
      "Bake for about 12-15 minutes, checking the thickest part using the fish cooking check below.",
      "Steam the kale for about 3-4 minutes until tender. If using chilled quinoa or beets for a warm meal, reheat them until steaming hot throughout.",
      "Serve the trout with the quinoa, kale and roasted beets."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Beets, roasted and sliced, Cooked quinoa. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Beef and Broccoli Stir-Fry with Ginger",
    "newName": "Beef and Broccoli Stir-Fry with Ginger",
    "expectedIngredients": [
      {
        "name": "Broccoli florets",
        "amount": "1 cup"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Garlic, minced",
        "amount": "1 clove"
      },
      {
        "name": "Lean beef strips",
        "amount": "150 g"
      },
      {
        "name": "Tamari",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Stir-fry beef strips over high heat until browned, about 3-4 minutes, then remove from the pan.",
      "Stir-fry broccoli in the same pan for 3-4 minutes.",
      "Add ginger and garlic, and stir-fry for 30 seconds.",
      "Return beef to the pan with tamari and toss to combine."
    ],
    "instructions": [
      "Cut the beef into thin strips and the broccoli into small florets; grate the ginger and mince the garlic.",
      "Heat a good non-stick pan over medium-high heat. Cook the beef in one layer for about 3-4 minutes, turning, then check it using the whole-cut beef cooking check below.",
      "Transfer to a clean plate and rest for 3 minutes. Add broccoli and 2 tablespoons of water to the pan; cover and cook over medium heat for about 3-4 minutes until tender.",
      "Uncover, add the ginger and garlic and stir for about 30 seconds, adding a splash of water if the pan is dry.",
      "Return the rested beef, add the tamari and toss until hot throughout, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "whole-cut-meat",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Beef and Quinoa Stuffed Bell Peppers (Non-Vegan Alt)",
    "newName": "Beef and Quinoa Stuffed Bell Peppers (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Bell peppers, halved",
        "amount": "2"
      },
      {
        "name": "Black beans",
        "amount": "1/2 cup"
      },
      {
        "name": "Cooked quinoa",
        "amount": "1/2 cup"
      },
      {
        "name": "Corn kernels",
        "amount": "1/4 cup"
      },
      {
        "name": "Lean ground beef",
        "amount": "150 g"
      },
      {
        "name": "Tomato, diced",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 190C/375F.",
      "Brown ground beef in a pan, about 5 minutes.",
      "Mix browned beef with cooked quinoa, black beans, corn, and tomato.",
      "Spoon the mixture into the halved bell peppers and bake for 25-30 minutes, until peppers soften."
    ],
    "instructions": [
      "Preheat a conventional oven to 190°C. Halve the bell peppers and remove their seeds; use ready-cooked quinoa and drained, cooked beans and corn.",
      "Brown the ground beef in a non-stick frying pan over medium heat for about 6-8 minutes, breaking up clumps. Check it using the ground-meat cooking check below.",
      "Mix the cooked beef with the quinoa, beans, corn and diced tomato.",
      "Fill the pepper halves and place in a baking dish with a small splash of water around the base. Bake for about 25-30 minutes until the peppers are tender and the filling is hot throughout.",
      "Use the casserole cooking check below before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked quinoa. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "ground-meat",
        "casserole",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Beet, Walnut, and Chickpea Salad with Goat Cheese",
    "newName": "Beet, Walnut, and Chickpea Salad with Goat Cheese",
    "expectedIngredients": [
      {
        "name": "Beets, roasted and sliced",
        "amount": "1/2 cup"
      },
      {
        "name": "Chickpeas",
        "amount": "1/2 cup"
      },
      {
        "name": "Goat cheese, crumbled",
        "amount": "30 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Mixed greens",
        "amount": "2 cups"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Orange segments",
        "amount": "1/4 cup"
      },
      {
        "name": "Walnuts",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Arrange mixed greens on a plate.",
      "Top with roasted beet slices, chickpeas, and orange segments.",
      "Scatter walnuts and crumbled goat cheese on top.",
      "Drizzle with olive oil and lemon juice before serving."
    ],
    "instructions": [
      "Arrange mixed greens on a plate.",
      "Top with roasted beet slices, chickpeas, and orange segments.",
      "Scatter walnuts and crumbled goat cheese on top.",
      "Drizzle with olive oil and lemon juice before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Beets, roasted and sliced. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Braised Cabbage and Apple with Soft-Boiled Egg",
    "newName": "Braised Cabbage and Apple with Soft-Boiled Egg",
    "expectedIngredients": [
      {
        "name": "Apple, sliced",
        "amount": "1/2"
      },
      {
        "name": "Cabbage, shredded",
        "amount": "2 cups"
      },
      {
        "name": "Caraway seeds",
        "amount": "1/2 tsp"
      },
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salt and pepper",
        "amount": "to taste"
      }
    ],
    "expectedInstructions": [
      "Heat olive oil in a pan over low-medium heat.",
      "Add shredded cabbage, apple, and caraway seeds.",
      "Cover and braise for about 15 minutes, stirring occasionally, until soft.",
      "Season to taste with salt and pepper.",
      "Soft-boil the egg for 6-7 minutes, halve, and place on top of the braised cabbage."
    ],
    "instructions": [
      "Heat olive oil in a pan over low-medium heat.",
      "Add shredded cabbage, apple, and caraway seeds.",
      "Cover and braise for about 15 minutes, stirring occasionally, until soft.",
      "Season to taste with salt and pepper.",
      "Soft-boil the egg for 6-7 minutes, halve, and place on top of the braised cabbage."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "This recipe has a soft-egg option; read the soft-egg cooking check before choosing a runny yolk."
      ],
      "cookingChecks": [
        "soft-egg",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.fda.gov/food/buy-store-serve-safe-food/what-you-need-know-about-egg-safety"
      ]
    }
  },
  {
    "name": "Buckwheat Pancakes with Blueberry Compote",
    "newName": "Buckwheat Pancakes with Blueberry Compote",
    "expectedIngredients": [
      {
        "name": "Banana, sliced",
        "amount": "1/2"
      },
      {
        "name": "Blueberries",
        "amount": "1/2 cup"
      },
      {
        "name": "Buckwheat flour",
        "amount": "1/2 cup"
      },
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Milk",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Whisk buckwheat flour, egg, and milk into a smooth batter.",
      "Cook spoonfuls of batter on a lightly oiled pan over medium heat, about 2 minutes per side.",
      "Meanwhile, simmer blueberries with a splash of water and cinnamon for 5 minutes until saucy.",
      "Serve pancakes topped with blueberry compote and banana slices."
    ],
    "instructions": [
      "Whisk the buckwheat flour, egg and milk into a smooth batter.",
      "Warm a good non-stick frying pan over medium heat; cook small spoonfuls for about 2 minutes per side until golden and set with no wet centre.",
      "Meanwhile, simmer the blueberries, cinnamon and a splash of water in a small saucepan for about 5 minutes until saucy.",
      "Use the egg-dish cooking check below for the pancakes, then serve with the compote and sliced banana."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Chia Seed Pudding Cup with Milk, Honey, and Mixed Berries (Non-Vegan Alt)",
    "newName": "Chia Seed Pudding Cup with Milk, Honey, and Mixed Berries (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "3 tbsp"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Mixed berries",
        "amount": "1/2 cup"
      },
      {
        "name": "Vanilla extract",
        "amount": "1/4 tsp"
      },
      {
        "name": "Whole milk",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Stir chia seeds into whole milk with vanilla extract and honey in a small jar.",
      "Cover and refrigerate overnight.",
      "Top with mixed berries before eating."
    ],
    "instructions": [
      "Stir chia seeds into whole milk with vanilla extract and honey in a small jar.",
      "Cover and refrigerate overnight.",
      "Top with mixed berries before eating."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chia Seed Pudding Cup with Mixed Berries",
    "newName": "Chia Seed Pudding Cup with Mixed Berries",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "3 tbsp"
      },
      {
        "name": "Mixed berries",
        "amount": "1/2 cup"
      },
      {
        "name": "Plant milk",
        "amount": "1 cup"
      },
      {
        "name": "Vanilla extract",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Stir chia seeds into plant milk with vanilla extract in a small jar.",
      "Cover and refrigerate overnight.",
      "Top with mixed berries before eating."
    ],
    "instructions": [
      "Stir chia seeds into plant milk with vanilla extract in a small jar.",
      "Cover and refrigerate overnight.",
      "Top with mixed berries before eating."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chia Seed Pudding with Mango and Coconut",
    "newName": "Chia Seed Pudding with Mango and Coconut",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "3 tbsp"
      },
      {
        "name": "Coconut flakes",
        "amount": "1 tbsp"
      },
      {
        "name": "Coconut milk",
        "amount": "1 cup"
      },
      {
        "name": "Mango, diced",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Stir chia seeds into coconut milk in a jar or bowl.",
      "Cover and refrigerate overnight, stirring once after 30 minutes if possible.",
      "Top with diced mango and coconut flakes before serving."
    ],
    "instructions": [
      "Stir chia seeds into coconut milk in a jar or bowl.",
      "Cover and refrigerate overnight, stirring once after 30 minutes if possible.",
      "Top with diced mango and coconut flakes before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chia Seed Pudding with Mango and Greek Yogurt (Non-Vegan Alt)",
    "newName": "Chia Seed Pudding with Mango and Greek Yogurt (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Chia seeds",
        "amount": "3 tbsp"
      },
      {
        "name": "Coconut flakes",
        "amount": "1 tbsp"
      },
      {
        "name": "Greek yogurt",
        "amount": "2 tbsp"
      },
      {
        "name": "Mango, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Whole milk",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Stir chia seeds into whole milk in a jar.",
      "Cover and refrigerate overnight.",
      "Swirl in Greek yogurt before serving.",
      "Top with diced mango and coconut flakes."
    ],
    "instructions": [
      "Stir chia seeds into whole milk in a jar.",
      "Cover and refrigerate overnight.",
      "Swirl in Greek yogurt before serving.",
      "Top with diced mango and coconut flakes."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chicken Sausage and Sweet Potato Breakfast Skillet",
    "newName": "Chicken Sausage and Sweet Potato Breakfast Skillet",
    "expectedIngredients": [
      {
        "name": "Bell pepper, diced",
        "amount": "1/2"
      },
      {
        "name": "Chicken sausage, sliced",
        "amount": "100 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Sweet potato, diced",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Heat olive oil in a skillet and brown the sliced chicken sausage, about 4 minutes.",
      "Add diced sweet potato and bell pepper, cook covered for 10-12 minutes, stirring occasionally, until tender.",
      "Stir in spinach and cook until just wilted."
    ],
    "instructions": [
      "Cut the sweet potato into small, roughly 1 cm cubes; slice the chicken sausage and dice the bell pepper.",
      "Heat the olive oil in a non-stick frying pan over medium heat. Add the sweet potato and 2 tablespoons of water, cover and cook for about 8-10 minutes, stirring occasionally.",
      "Add the sausage and bell pepper; cook for about 8-10 minutes more, stirring and adding a little water if needed, until the sweet potato is tender.",
      "For raw chicken sausage, check it using the poultry cooking check below. If the sausage is already fully cooked, follow its packet reheating instructions.",
      "Stir in the spinach until wilted and serve hot."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Chicken and Avocado Lettuce Cups",
    "newName": "Chicken and Avocado Lettuce Cups",
    "expectedIngredients": [
      {
        "name": "Avocado, diced",
        "amount": "1/2"
      },
      {
        "name": "Cilantro, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Cooked chicken, shredded",
        "amount": "100 g"
      },
      {
        "name": "Lettuce leaves",
        "amount": "4"
      },
      {
        "name": "Lime juice",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Toss shredded chicken with lime juice and cilantro.",
      "Spoon the chicken mixture into lettuce leaves.",
      "Top with diced avocado before serving."
    ],
    "instructions": [
      "Toss shredded chicken with lime juice and cilantro.",
      "Spoon the chicken mixture into lettuce leaves.",
      "Top with diced avocado before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked chicken, shredded. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Chicken and Lentil Curry with Brown Rice (Non-Vegan Alt)",
    "newName": "Chicken and Lentil Curry with Brown Rice (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Bell pepper, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Carrot, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Chicken thighs, diced",
        "amount": "150 g"
      },
      {
        "name": "Lentils",
        "amount": "1/2 cup"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Brown chicken thighs in a pot for 4-5 minutes.",
      "Add lentils, carrot, bell pepper, and turmeric, cover with water or broth, and simmer for 20-25 minutes.",
      "Stir in spinach and cook until wilted.",
      "Serve over cooked brown rice."
    ],
    "instructions": [
      "Use dried red split lentils for the stated simmering time; rinse them. Cut boneless chicken thighs into about 2 cm pieces and dice the vegetables.",
      "Brown the chicken in a good non-stick saucepan over medium heat for about 4-5 minutes; add a splash of water if it starts to stick.",
      "Add the lentils, carrot, bell pepper, turmeric and about 2 cups of water. Bring to a gentle bubble, cover loosely and simmer for about 20-25 minutes.",
      "Stir regularly, adding a little water if needed. Continue until the lentils are soft and the chicken meets the poultry cooking check below.",
      "Stir in the spinach until wilted. Serve over separately cooked brown rice, reheated thoroughly if chilled."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use dried red split lentils, rinsed, for the stated simmering times. Other lentil varieties may need longer and more liquid; follow the packet and cook until soft.",
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Chicken and Lentil Soup with Turmeric and Ginger (Non-Vegan Alt)",
    "newName": "Chicken and Lentil Soup with Turmeric and Ginger (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Carrot, diced",
        "amount": "1/2"
      },
      {
        "name": "Cooked chicken, shredded",
        "amount": "1/2 cup"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Lentils",
        "amount": "1/2 cup"
      },
      {
        "name": "Onion, diced",
        "amount": "1/4"
      },
      {
        "name": "Parsley, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      },
      {
        "name": "Vegetable broth",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Saute onion, carrot, and ginger in a pot for 3-4 minutes.",
      "Add lentils, turmeric, and broth, and simmer for 20-25 minutes until lentils are soft.",
      "Stir in shredded cooked chicken and warm through, about 2 minutes.",
      "Finish with chopped parsley before serving."
    ],
    "instructions": [
      "Use dried red split lentils for the stated cooking time; rinse them. Dice the onion and carrot and grate the ginger.",
      "Cook the onion, carrot and ginger in a saucepan over medium heat with a few tablespoons of the measured broth for about 3-4 minutes, adding more broth if needed to prevent sticking.",
      "Add the lentils, turmeric and remaining broth. Bring to a gentle boil, lower the heat and simmer for about 20-25 minutes until the lentils are soft.",
      "Add the already-cooked shredded chicken and simmer for about 3-5 minutes until thoroughly reheated; use the reheating check below.",
      "Finish with the parsley and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked chicken, shredded. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use dried red split lentils, rinsed, for the stated simmering times. Other lentil varieties may need longer and more liquid; follow the packet and cook until soft."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Chicken and Spinach Curry with Brown Rice (Non-Vegan Alt)",
    "newName": "Chicken and Spinach Curry with Brown Rice (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "1/2 cup"
      },
      {
        "name": "Chicken thighs, diced",
        "amount": "150 g"
      },
      {
        "name": "Chickpeas",
        "amount": "1/2 cup"
      },
      {
        "name": "Coconut milk",
        "amount": "1/2 cup"
      },
      {
        "name": "Cumin",
        "amount": "1/4 tsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Simmer chicken thighs, chickpeas, cherry tomatoes, coconut milk, turmeric, and cumin in a pan for 12-15 minutes, until chicken is cooked through.",
      "Stir in spinach and cook until wilted, about 2 minutes.",
      "Serve over cooked brown rice."
    ],
    "instructions": [
      "Use drained canned or otherwise fully cooked chickpeas, cooked brown rice and boneless chicken thighs cut into about 2 cm pieces.",
      "Combine the chicken, chickpeas, tomatoes, coconut milk, turmeric and cumin in a saucepan. Bring to a gentle bubble over medium heat.",
      "Cover loosely and simmer over low-medium heat for about 15-20 minutes, stirring occasionally and adding a little water if the sauce gets too thick.",
      "Check the largest chicken pieces using the poultry cooking check below; continue cooking if needed.",
      "Add the spinach for about 2 minutes until wilted and serve with the cooked brown rice, thoroughly reheated if chilled."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans.",
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Chicken and Spinach Stew with Whole Grain Bread (Non-Vegan Alt)",
    "newName": "Chicken and Spinach Stew with Whole Grain Bread (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Chicken thighs, diced",
        "amount": "150 g"
      },
      {
        "name": "Chickpeas",
        "amount": "1/2 cup"
      },
      {
        "name": "Cumin",
        "amount": "1/4 tsp"
      },
      {
        "name": "Garlic, minced",
        "amount": "1 clove"
      },
      {
        "name": "Smoked paprika",
        "amount": "1/4 tsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Tomato, diced",
        "amount": "1 cup"
      },
      {
        "name": "Whole grain bread",
        "amount": "1 slice"
      }
    ],
    "expectedInstructions": [
      "Brown chicken thighs in a pot, about 4-5 minutes.",
      "Add chickpeas, tomato, garlic, cumin, and smoked paprika, and simmer for 15-18 minutes until chicken is cooked through.",
      "Stir in spinach and cook until wilted.",
      "Serve with a slice of whole grain bread."
    ],
    "instructions": [
      "Use drained canned or otherwise fully cooked chickpeas. Cut boneless chicken thighs into about 2 cm pieces and mince the garlic.",
      "Brown the chicken in a good non-stick saucepan over medium heat for about 4-5 minutes; add a splash of water if needed to prevent sticking.",
      "Add the chickpeas, tomato, garlic, cumin and paprika with about 1/4 cup of water. Bring to a gentle simmer, cover loosely and cook for about 15-20 minutes.",
      "Stir occasionally and add water if needed. Check the largest chicken pieces using the poultry cooking check below.",
      "Stir in the spinach until wilted and serve with the listed wholegrain bread."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans.",
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Chickpea and Spinach Curry with Brown Rice",
    "newName": "Chickpea and Spinach Curry with Brown Rice",
    "expectedIngredients": [
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "1/2 cup"
      },
      {
        "name": "Chickpeas",
        "amount": "1 cup"
      },
      {
        "name": "Coconut milk",
        "amount": "1/2 cup"
      },
      {
        "name": "Cumin",
        "amount": "1/4 tsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Simmer chickpeas, cherry tomatoes, coconut milk, turmeric, and cumin in a pan for 8-10 minutes.",
      "Stir in spinach and cook until wilted, about 2 minutes.",
      "Serve over cooked brown rice."
    ],
    "instructions": [
      "Simmer chickpeas, cherry tomatoes, coconut milk, turmeric, and cumin in a pan for 8-10 minutes.",
      "Stir in spinach and cook until wilted, about 2 minutes.",
      "Serve over cooked brown rice."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Chickpea and Spinach Stew with Whole Grain Bread",
    "newName": "Chickpea and Spinach Stew with Whole Grain Bread",
    "expectedIngredients": [
      {
        "name": "Chickpeas",
        "amount": "1 cup"
      },
      {
        "name": "Cumin",
        "amount": "1/4 tsp"
      },
      {
        "name": "Garlic, minced",
        "amount": "1 clove"
      },
      {
        "name": "Smoked paprika",
        "amount": "1/4 tsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Tomato, diced",
        "amount": "1 cup"
      },
      {
        "name": "Whole grain bread",
        "amount": "1 slice"
      }
    ],
    "expectedInstructions": [
      "Simmer chickpeas, tomato, garlic, cumin, and smoked paprika in a pot for 10-12 minutes.",
      "Stir in spinach and cook until wilted, about 2 minutes.",
      "Serve with a slice of whole grain bread."
    ],
    "instructions": [
      "Simmer chickpeas, tomato, garlic, cumin, and smoked paprika in a pot for 10-12 minutes.",
      "Stir in spinach and cook until wilted, about 2 minutes.",
      "Serve with a slice of whole grain bread."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Cottage Cheese and Egg Scramble with Chives",
    "newName": "Cottage Cheese and Egg Scramble with Chives",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Chives, chopped",
        "amount": "1 tsp"
      },
      {
        "name": "Cottage cheese",
        "amount": "2 tbsp"
      },
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Whisk eggs with cottage cheese and black pepper.",
      "Heat olive oil in a pan over low heat.",
      "Pour in the egg mixture and scramble gently until soft curds form.",
      "Finish with chopped chives."
    ],
    "instructions": [
      "Beat the eggs with the cottage cheese and black pepper.",
      "Heat the olive oil in a non-stick frying pan over low-medium heat.",
      "Pour in the mixture and stir gently for about 3-5 minutes until the egg is set with no liquid parts; use the egg-dish check below.",
      "Scatter over the chives and serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Cottage Cheese with Berries and Flaxseed",
    "newName": "Cottage Cheese with Berries and Flaxseed",
    "expectedIngredients": [
      {
        "name": "Cottage cheese",
        "amount": "1 cup"
      },
      {
        "name": "Ground flaxseed",
        "amount": "1 tbsp"
      },
      {
        "name": "Mixed berries",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Spoon cottage cheese into a bowl.",
      "Top with mixed berries.",
      "Sprinkle with ground flaxseed."
    ],
    "instructions": [
      "Spoon cottage cheese into a bowl.",
      "Top with mixed berries.",
      "Sprinkle with ground flaxseed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Cucumber, Red Onion, and Corn Salad with Herbed Yogurt Dressing",
    "newName": "Cucumber, Red Onion, and Corn Salad with Herbed Yogurt Dressing",
    "expectedIngredients": [
      {
        "name": "Corn kernels",
        "amount": "1/2 cup"
      },
      {
        "name": "Cucumber, thinly sliced",
        "amount": "1 cup"
      },
      {
        "name": "Dill, chopped",
        "amount": "1 tsp"
      },
      {
        "name": "Fresh mint, chopped",
        "amount": "1 tsp"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Mayonnaise",
        "amount": "1 tsp"
      },
      {
        "name": "Mustard",
        "amount": "1/2 tsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Plain yogurt",
        "amount": "1/4 cup"
      },
      {
        "name": "Red onion, thinly sliced",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Combine cucumber, red onion, and corn in a bowl.",
      "Whisk yogurt, mayonnaise, mustard, olive oil, lemon juice, mint, and dill for the dressing.",
      "Toss the dressing through the vegetables just before serving."
    ],
    "instructions": [
      "Combine cucumber, red onion, and corn in a bowl.",
      "Whisk yogurt, mayonnaise, mustard, olive oil, lemon juice, mint, and dill for the dressing.",
      "Toss the dressing through the vegetables just before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Dark Chocolate and Almonds",
    "newName": "Dark Chocolate and Almonds",
    "expectedIngredients": [
      {
        "name": "Almonds",
        "amount": "12"
      },
      {
        "name": "Dark chocolate (70%+ cacao)",
        "amount": "20 g"
      }
    ],
    "expectedInstructions": [
      "Portion a small square of dark chocolate.",
      "Serve alongside a small handful of almonds."
    ],
    "instructions": [
      "Portion a small square of dark chocolate.",
      "Serve alongside a small handful of almonds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Edamame and Soft-Boiled Egg with Sea Salt and Chili Flakes (Non-Vegan Alt)",
    "newName": "Edamame and Soft-Boiled Egg with Sea Salt and Chili Flakes (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Chili flakes",
        "amount": "pinch"
      },
      {
        "name": "Edamame, in pods",
        "amount": "1 cup"
      },
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Sea salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Steam or boil edamame pods for 4-5 minutes.",
      "Soft-boil the egg for 6-7 minutes, then halve.",
      "Serve edamame alongside the soft-boiled egg, sprinkled with sea salt and chili flakes."
    ],
    "instructions": [
      "Steam or boil edamame pods for 4-5 minutes.",
      "Soft-boil the egg for 6-7 minutes, then halve.",
      "Serve edamame alongside the soft-boiled egg, sprinkled with sea salt and chili flakes."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "This recipe has a soft-egg option; read the soft-egg cooking check before choosing a runny yolk."
      ],
      "cookingChecks": [
        "soft-egg",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.fda.gov/food/buy-store-serve-safe-food/what-you-need-know-about-egg-safety"
      ]
    }
  },
  {
    "name": "Edamame with Sea Salt and Chili Flakes",
    "newName": "Edamame with Sea Salt and Chili Flakes",
    "expectedIngredients": [
      {
        "name": "Chili flakes",
        "amount": "pinch"
      },
      {
        "name": "Edamame, in pods",
        "amount": "1 cup"
      },
      {
        "name": "Sea salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Steam or boil edamame pods for 4-5 minutes.",
      "Drain and sprinkle with sea salt and chili flakes."
    ],
    "instructions": [
      "Steam or boil edamame pods for 4-5 minutes.",
      "Drain and sprinkle with sea salt and chili flakes."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Fried Egg Toast with Sauteed Greens, Radish, and Pomegranate",
    "newName": "Fried Egg Toast with Sauteed Greens, Radish, and Pomegranate",
    "expectedIngredients": [
      {
        "name": "Chives, chopped",
        "amount": "1 tsp"
      },
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Garlic, minced",
        "amount": "1/2 clove"
      },
      {
        "name": "Microgreens",
        "amount": "small handful"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Radish, thinly sliced",
        "amount": "2-3 slices"
      },
      {
        "name": "Spinach or kale",
        "amount": "1 cup"
      },
      {
        "name": "Whole grain sourdough bread",
        "amount": "1 slice"
      }
    ],
    "expectedInstructions": [
      "Heat olive oil in a pan and saute garlic for 30 seconds.",
      "Add greens and cook until wilted, then pile onto toasted sourdough.",
      "In the same pan, fry an egg to your preference.",
      "Place the fried egg on top of the greens.",
      "Finish with radish, pomegranate seeds, microgreens, and chives."
    ],
    "instructions": [
      "Heat olive oil in a pan and saute garlic for 30 seconds.",
      "Add greens and cook until wilted, then pile onto toasted sourdough.",
      "In the same pan, fry an egg to your preference.",
      "Place the fried egg on top of the greens.",
      "Finish with radish, pomegranate seeds, microgreens, and chives."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "whole-egg",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Ginger Turmeric Stir-Fry with Shrimp, Bell Pepper, and Snap Peas (Non-Vegan Alt)",
    "newName": "Ginger Turmeric Stir-Fry with Shrimp, Bell Pepper, and Snap Peas (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Bell pepper, sliced",
        "amount": "1/2"
      },
      {
        "name": "Carrot, sliced",
        "amount": "1/2"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Shrimp, peeled",
        "amount": "150 g"
      },
      {
        "name": "Snap peas",
        "amount": "1/2 cup"
      },
      {
        "name": "Tamari",
        "amount": "1 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Stir-fry shrimp over medium-high heat until just pink, about 3 minutes, then remove from the pan.",
      "Stir-fry bell pepper, snap peas, and carrot in the same pan for 3-4 minutes.",
      "Add ginger and turmeric, and stir-fry for 30 seconds.",
      "Return shrimp to the pan with tamari and toss to combine."
    ],
    "instructions": [
      "Use peeled, deveined, fully thawed shrimp; slice the pepper and carrot thinly and grate the ginger.",
      "Heat a good non-stick pan over medium-high heat. Cook the shrimp for about 2-3 minutes per side until opaque throughout, using the shrimp cooking check below; remove to a clean plate.",
      "Add the pepper, snap peas, carrot and 2 tablespoons of water. Cover over medium heat for about 3-4 minutes until tender, then uncover.",
      "Add the ginger and turmeric and stir for about 30 seconds. Return the cooked shrimp with the tamari and toss until hot throughout, then serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use peeled, deveined, fully thawed shrimp for the stated timings."
      ],
      "cookingChecks": [
        "shrimp",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Ginger Turmeric Stir-Fry with Tofu, Bell Pepper, and Snap Peas",
    "newName": "Ginger Turmeric Stir-Fry with Tofu, Bell Pepper, and Snap Peas",
    "expectedIngredients": [
      {
        "name": "Bell pepper, sliced",
        "amount": "1/2"
      },
      {
        "name": "Carrot, sliced",
        "amount": "1/2"
      },
      {
        "name": "Firm tofu, cubed",
        "amount": "150 g"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Snap peas",
        "amount": "1/2 cup"
      },
      {
        "name": "Tamari",
        "amount": "1 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Pan-fry tofu cubes until golden on most sides, about 5-6 minutes, then remove from the pan.",
      "Stir-fry bell pepper, snap peas, and carrot in the same pan for 3-4 minutes.",
      "Add ginger and turmeric, and stir-fry for 30 seconds.",
      "Return tofu to the pan with tamari and toss to combine."
    ],
    "instructions": [
      "Drain firm tofu and pat it dry. Cut into roughly 2 cm cubes; slice the pepper and carrot thinly and grate the ginger.",
      "Heat a good non-stick pan over medium-high heat. Turn the tofu for about 5-8 minutes until golden on several sides, then move it to a plate.",
      "Add the pepper, snap peas, carrot and 2 tablespoons of water; cover and cook over medium heat for about 3-4 minutes until tender.",
      "Uncover, stir in the ginger and turmeric for about 30 seconds, then return the tofu with the tamari.",
      "Toss for another minute until hot throughout and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use firm tofu, drained and patted dry, so it holds its shape when cooked."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Golden Milk (Turmeric Latte)",
    "newName": "Golden Milk (Turmeric Latte)",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Honey (optional)",
        "amount": "1 tsp"
      },
      {
        "name": "Milk or plant milk",
        "amount": "1 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Warm milk in a small saucepan over medium heat.",
      "Whisk in turmeric, black pepper, and cinnamon.",
      "Continue whisking until warmed through and slightly frothy.",
      "Sweeten with honey if desired."
    ],
    "instructions": [
      "Warm milk in a small saucepan over medium heat.",
      "Whisk in turmeric, black pepper, and cinnamon.",
      "Continue whisking until warmed through and slightly frothy.",
      "Sweeten with honey if desired."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Golden Milk Smoothie Bowl with Dairy Milk and Honey (Non-Vegan Alt)",
    "newName": "Golden Milk Smoothie Bowl with Dairy Milk and Honey (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Blueberries",
        "amount": "2 tbsp"
      },
      {
        "name": "Chia seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Frozen banana",
        "amount": "1"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Mango, diced",
        "amount": "2 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      },
      {
        "name": "Whole milk",
        "amount": "3/4 cup"
      }
    ],
    "expectedInstructions": [
      "Blend frozen banana, whole milk, turmeric, and cinnamon until thick and smooth.",
      "Sweeten with honey and blend briefly to combine.",
      "Pour into a bowl.",
      "Top with diced mango, blueberries, and chia seeds."
    ],
    "instructions": [
      "Blend frozen banana, whole milk, turmeric, and cinnamon until thick and smooth.",
      "Sweeten with honey and blend briefly to combine.",
      "Pour into a bowl.",
      "Top with diced mango, blueberries, and chia seeds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Follow frozen fruit packet instructions; some berries must be heated and cooled before being eaten."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Greek Yogurt Parfait with Blueberries, Flaxseed, Honey",
    "newName": "Greek Yogurt Parfait with Blueberries, Flaxseed, Honey",
    "expectedIngredients": [
      {
        "name": "Blueberries",
        "amount": "1/2 cup"
      },
      {
        "name": "Greek yogurt",
        "amount": "1 cup"
      },
      {
        "name": "Ground flaxseed",
        "amount": "1 tbsp"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Spoon a third of the yogurt into a glass.",
      "Layer with a portion of blueberries and flaxseed.",
      "Repeat the layers until the glass is full.",
      "Drizzle honey on top before serving."
    ],
    "instructions": [
      "Spoon a third of the yogurt into a glass.",
      "Layer with a portion of blueberries and flaxseed.",
      "Repeat the layers until the glass is full.",
      "Drizzle honey on top before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Greek Yogurt with Honey, Cinnamon, and Pomegranate",
    "newName": "Greek Yogurt with Honey, Cinnamon, and Pomegranate",
    "expectedIngredients": [
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Greek yogurt",
        "amount": "1 cup"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Spoon Greek yogurt into a bowl.",
      "Drizzle with honey and dust with cinnamon.",
      "Top with pomegranate seeds."
    ],
    "instructions": [
      "Spoon Greek yogurt into a bowl.",
      "Drizzle with honey and dust with cinnamon.",
      "Top with pomegranate seeds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Green Smoothie Bowl (Spinach, Pineapple, Ginger, Flaxseed)",
    "newName": "Green Smoothie Bowl (Spinach, Pineapple, Ginger, Flaxseed)",
    "expectedIngredients": [
      {
        "name": "Fresh ginger",
        "amount": "1 tsp"
      },
      {
        "name": "Frozen pineapple",
        "amount": "1 cup"
      },
      {
        "name": "Granola",
        "amount": "2 tbsp"
      },
      {
        "name": "Ground flaxseed",
        "amount": "1 tbsp"
      },
      {
        "name": "Kiwi, sliced",
        "amount": "1"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Blend spinach, frozen pineapple, ginger, and flaxseed with a small splash of water until thick and smooth.",
      "Pour into a bowl.",
      "Top with sliced kiwi and granola."
    ],
    "instructions": [
      "Blend spinach, frozen pineapple, ginger, and flaxseed with a small splash of water until thick and smooth.",
      "Pour into a bowl.",
      "Top with sliced kiwi and granola."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Green Smoothie Bowl with Greek Yogurt (Non-Vegan Alt)",
    "newName": "Green Smoothie Bowl with Greek Yogurt (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Fresh ginger",
        "amount": "1 tsp"
      },
      {
        "name": "Frozen pineapple",
        "amount": "1 cup"
      },
      {
        "name": "Granola",
        "amount": "2 tbsp"
      },
      {
        "name": "Greek yogurt",
        "amount": "1/2 cup"
      },
      {
        "name": "Kiwi, sliced",
        "amount": "1"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Blend spinach, frozen pineapple, ginger, and Greek yogurt until thick and smooth.",
      "Pour into a bowl.",
      "Top with sliced kiwi and granola."
    ],
    "instructions": [
      "Blend spinach, frozen pineapple, ginger, and Greek yogurt until thick and smooth.",
      "Pour into a bowl.",
      "Top with sliced kiwi and granola."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Green Tea and Mixed Nuts",
    "newName": "Green Tea and Mixed Nuts",
    "expectedIngredients": [
      {
        "name": "Green tea bag",
        "amount": "1"
      },
      {
        "name": "Mixed nuts (almonds, walnuts, pistachios)",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Brew green tea according to package instructions.",
      "Serve alongside a small portion of mixed nuts."
    ],
    "instructions": [
      "Brew green tea according to package instructions.",
      "Serve alongside a small portion of mixed nuts."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Green Tea with Honey-Drizzled Mixed Nuts (Non-Vegan Alt)",
    "newName": "Green Tea with Honey-Drizzled Mixed Nuts (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Green tea bag",
        "amount": "1"
      },
      {
        "name": "Honey",
        "amount": "1/2 tsp"
      },
      {
        "name": "Mixed nuts",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Brew green tea according to package instructions.",
      "Lightly drizzle mixed nuts with honey.",
      "Serve nuts alongside the tea."
    ],
    "instructions": [
      "Brew green tea according to package instructions.",
      "Lightly drizzle mixed nuts with honey.",
      "Serve nuts alongside the tea."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Grilled Chicken and Broccoli Bowl with Turmeric Rice",
    "newName": "Grilled Chicken and Broccoli Bowl with Turmeric Rice",
    "expectedIngredients": [
      {
        "name": "Broccoli florets",
        "amount": "1 cup"
      },
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Carrot, shredded",
        "amount": "2 tbsp"
      },
      {
        "name": "Chicken breast",
        "amount": "120 g"
      },
      {
        "name": "Turmeric",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Grill or pan-sear the chicken breast until cooked through, about 6 minutes per side.",
      "Steam broccoli florets for 4-5 minutes until tender.",
      "Stir turmeric through the cooked brown rice.",
      "Slice the chicken and serve over the turmeric rice with broccoli and shredded carrot."
    ],
    "instructions": [
      "Use cooked brown rice. Cut the chicken breast to an even thickness of about 1.5-2 cm and keep it separate from the vegetables.",
      "Heat a grill pan or good non-stick frying pan over medium heat. Cook the chicken for about 5-6 minutes per side; check the thickest part using the poultry cooking check below and cook longer if needed.",
      "Steam broccoli florets for about 4-5 minutes until tender and wash the shredded carrot.",
      "Warm the cooked rice in a covered saucepan with the turmeric and a splash of water, stirring until steaming hot throughout.",
      "Slice the cooked chicken on a clean board and serve with the turmeric rice, broccoli and carrot."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Grilled Chicken and Kale Bowl with Lemon-Anchovy Dressing",
    "newName": "Grilled Chicken and Kale Bowl with Lemon-Anchovy Dressing",
    "expectedIngredients": [
      {
        "name": "Anchovy fillet, mashed",
        "amount": "1"
      },
      {
        "name": "Chicken breast",
        "amount": "120 g"
      },
      {
        "name": "Kale, chopped",
        "amount": "2 cups"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "2 tbsp"
      },
      {
        "name": "Parmesan, shaved",
        "amount": "15 g"
      }
    ],
    "expectedInstructions": [
      "Grill or pan-sear the chicken breast until cooked through, about 6 minutes per side.",
      "Massage chopped kale with 1 tablespoon of olive oil and half the lemon juice.",
      "Whisk remaining olive oil, lemon juice, and mashed anchovy for the dressing.",
      "Slice the chicken and place over the kale.",
      "Drizzle with dressing and top with shaved parmesan."
    ],
    "instructions": [
      "Make the chicken breast an even thickness of about 1.5-2 cm. Heat a grill pan or good non-stick frying pan over medium heat.",
      "Cook the chicken for about 5-6 minutes per side, checking its thickest part using the poultry cooking check below; cook longer if needed.",
      "Wash and chop the kale, then massage it with half the olive oil and half the lemon juice for about 1-2 minutes until softened.",
      "Whisk the remaining oil and lemon juice with the mashed ready-to-eat anchovy.",
      "Slice the fully cooked chicken on a clean board, place over the kale, drizzle over the dressing and add the parmesan."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Grilled Mackerel with Sauteed Spinach, Garlic, and Roasted Tomatoes",
    "newName": "Grilled Mackerel with Sauteed Spinach, Garlic, and Roasted Tomatoes",
    "expectedIngredients": [
      {
        "name": "Cherry tomatoes, halved",
        "amount": "1/2 cup"
      },
      {
        "name": "Garlic, minced",
        "amount": "1 clove"
      },
      {
        "name": "Mackerel fillet",
        "amount": "150 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Roast cherry tomatoes with a little olive oil at 200C/400F for 10 minutes.",
      "Grill or pan-sear the mackerel fillet, about 3-4 minutes per side.",
      "Heat remaining olive oil in a pan and saute garlic for 30 seconds, then add spinach and cook until wilted.",
      "Serve the mackerel with sauteed spinach and roasted tomatoes."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Toss the halved tomatoes with about half the olive oil and roast for about 10-15 minutes until softened.",
      "Use a fresh or fully thawed mackerel fillet. Heat a non-stick pan over medium heat and cook for about 3-4 minutes per side, checking the thickest part using the fish cooking check below.",
      "In another pan, heat the remaining olive oil over medium heat. Add the garlic for about 30 seconds, then the spinach for about 1-2 minutes until wilted.",
      "Serve the cooked mackerel with the spinach and roasted tomatoes."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Grilled Peach, Burrata, and Tomato Salad with Basil and Pistachios",
    "newName": "Grilled Peach, Burrata, and Tomato Salad with Basil and Pistachios",
    "expectedIngredients": [
      {
        "name": "Arugula or spinach",
        "amount": "2 cups"
      },
      {
        "name": "Balsamic glaze",
        "amount": "1 tsp"
      },
      {
        "name": "Basil leaves, torn",
        "amount": "2 tbsp"
      },
      {
        "name": "Burrata",
        "amount": "100 g"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "1/2 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Peaches, halved",
        "amount": "2"
      },
      {
        "name": "Pistachios, toasted and chopped",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Grill peach halves cut-side down for 2-3 minutes until charred, then let cool slightly and slice.",
      "Toss greens with cherry tomatoes and olive oil.",
      "Arrange peaches and torn burrata on top of the greens.",
      "Scatter basil and pistachios over the salad.",
      "Finish with a drizzle of balsamic glaze."
    ],
    "instructions": [
      "Grill peach halves cut-side down for 2-3 minutes until charred, then let cool slightly and slice.",
      "Toss greens with cherry tomatoes and olive oil.",
      "Arrange peaches and torn burrata on top of the greens.",
      "Scatter basil and pistachios over the salad.",
      "Finish with a drizzle of balsamic glaze."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Grilled Salmon Salad with Sweet Potato, Mixed Greens, and Walnuts",
    "newName": "Grilled Salmon Salad with Sweet Potato, Mixed Greens, and Walnuts",
    "expectedIngredients": [
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Mixed greens",
        "amount": "2 cups"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salmon fillet",
        "amount": "150 g"
      },
      {
        "name": "Sweet potato, diced and roasted",
        "amount": "1/2 cup"
      },
      {
        "name": "Walnuts",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Grill or pan-sear the salmon fillet, about 4 minutes per side.",
      "Toss mixed greens with olive oil and lemon juice.",
      "Arrange greens on a plate, top with roasted sweet potato and walnuts.",
      "Place the salmon on top and serve."
    ],
    "instructions": [
      "Use sweet potato that has already been roasted until tender; wash and dry the greens.",
      "Heat a grill pan or non-stick frying pan over medium heat. Cook fresh or thawed salmon for about 4-5 minutes per side, checking its thickest part using the fish cooking check below.",
      "Toss the greens with the olive oil and lemon juice. Add the roasted sweet potato and walnuts.",
      "Place the fully cooked salmon over the salad and serve promptly."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Sweet potato, diced and roasted. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use fresh or fully thawed fish for these timings, not a frozen fillet; follow the pack if it specifies a different cooking method."
      ],
      "cookingChecks": [
        "fish",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Grilled Shrimp with Asparagus, Lemon, and Cherry Tomatoes",
    "newName": "Grilled Shrimp with Asparagus, Lemon, and Cherry Tomatoes",
    "expectedIngredients": [
      {
        "name": "Asparagus",
        "amount": "8 spears"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "1/2 cup"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Shrimp, peeled",
        "amount": "150 g"
      }
    ],
    "expectedInstructions": [
      "Toss shrimp, asparagus, and cherry tomatoes with olive oil.",
      "Grill for 3-4 minutes, turning once, until shrimp is pink and asparagus is tender.",
      "Finish with a squeeze of fresh lemon juice before serving."
    ],
    "instructions": [
      "Use peeled, deveined, thawed shrimp; trim the asparagus and halve the tomatoes.",
      "Toss these with the olive oil. Warm a grill pan over medium-high heat; use a grill tray or basket if cooking on a barbecue.",
      "Cook the asparagus and tomatoes for about 4-6 minutes, turning, until tender; place the shrimp on the grill for about 2-3 minutes per side.",
      "Check that the shrimp is opaque throughout using the shrimp cooking check below. Finish everything with the lemon juice and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use peeled, deveined, fully thawed shrimp for the stated timings."
      ],
      "cookingChecks": [
        "shrimp",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Ham and Spinach Frittata Muffins",
    "newName": "Ham and Spinach Frittata Muffins",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "6"
      },
      {
        "name": "Lean deli ham, chopped",
        "amount": "1/2 cup"
      },
      {
        "name": "Olive oil (for greasing)",
        "amount": "1 tsp"
      },
      {
        "name": "Spinach, chopped",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 180C/350F and grease a 6-cup muffin tin with olive oil.",
      "Whisk eggs in a bowl, then stir in chopped ham and spinach.",
      "Divide the mixture evenly among the muffin cups.",
      "Bake for 18-20 minutes until set.",
      "Cool slightly before removing; makes 6 muffins. Refrigerate extras and reheat through the week."
    ],
    "instructions": [
      "Preheat a conventional oven to 180°C and grease a 6-cup muffin tin with the listed olive oil.",
      "Use ready-to-eat cooked deli ham. Beat the eggs, then stir in the chopped ham and spinach.",
      "Divide among the muffin cups and bake for about 18-20 minutes until the centres are fully set; use the casserole cooking check below.",
      "Let stand for about 5 minutes before removing. For extras, use the storage and reheating guidance below rather than keeping them for a whole week."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use ready-to-eat cooked/deli or smoked products as specified and follow their pack directions and use-by date; do not substitute raw meat or raw fish into an assembly-only method."
      ],
      "cookingChecks": [
        "egg-dish",
        "casserole",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Hard-Boiled Eggs with Everything Seasoning",
    "newName": "Hard-Boiled Eggs with Everything Seasoning",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Everything bagel seasoning",
        "amount": "1/2 tsp"
      },
      {
        "name": "Sea salt",
        "amount": "pinch"
      }
    ],
    "expectedInstructions": [
      "Hard-boil the eggs for 9-10 minutes, then transfer to cold water.",
      "Peel and halve the eggs.",
      "Sprinkle with everything seasoning and sea salt before serving."
    ],
    "instructions": [
      "Bring enough water to cover the eggs to a gentle boil in a small saucepan.",
      "Lower in the eggs and simmer for about 10-12 minutes, until the yolks and whites are firm.",
      "Transfer to cold water and peel once cool enough to handle.",
      "Halve and sprinkle with the everything seasoning and sea salt."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.fda.gov/food/buy-store-serve-safe-food/what-you-need-know-about-egg-safety"
      ]
    }
  },
  {
    "name": "Herb-Roasted Chicken with Root Vegetables",
    "newName": "Herb-Roasted Chicken with Root Vegetables",
    "expectedIngredients": [
      {
        "name": "Bone-in chicken thighs",
        "amount": "2"
      },
      {
        "name": "Carrots, chopped",
        "amount": "1 cup"
      },
      {
        "name": "Olive oil",
        "amount": "2 tbsp"
      },
      {
        "name": "Onion, chopped",
        "amount": "1/2"
      },
      {
        "name": "Parsnip, chopped",
        "amount": "1/2 cup"
      },
      {
        "name": "Rosemary, chopped",
        "amount": "1 tsp"
      },
      {
        "name": "Thyme, chopped",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Toss carrots, parsnip, and onion with olive oil, rosemary, and thyme in a baking dish.",
      "Nestle chicken thighs on top of the vegetables.",
      "Roast for 40-45 minutes, until the chicken is cooked through and vegetables are tender."
    ],
    "instructions": [
      "Preheat oven to 200C/400F.",
      "Toss carrots, parsnip, and onion with olive oil, rosemary, and thyme in a baking dish.",
      "Nestle chicken thighs on top of the vegetables.",
      "Roast for 40-45 minutes, until the chicken is cooked through and vegetables are tender."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Honey-Pecan Brie Sweet Potato Rounds",
    "newName": "Honey-Pecan Brie Sweet Potato Rounds",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Brie, sliced",
        "amount": "60 g"
      },
      {
        "name": "Fresh thyme leaves",
        "amount": "1/2 tsp"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Pecans, halved",
        "amount": "8"
      },
      {
        "name": "Sweet potato, sliced into rounds",
        "amount": "1"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Toss sweet potato rounds with olive oil and black pepper, and spread on a baking sheet.",
      "Roast for 20-25 minutes, flipping halfway.",
      "Top each round with a small piece of brie and a pecan half, and return to the oven for 3-5 minutes until the cheese softens.",
      "Drizzle with honey and scatter fresh thyme leaves."
    ],
    "instructions": [
      "Preheat oven to 200C/400F.",
      "Toss sweet potato rounds with olive oil and black pepper, and spread on a baking sheet.",
      "Roast for 20-25 minutes, flipping halfway.",
      "Top each round with a small piece of brie and a pecan half, and return to the oven for 3-5 minutes until the cheese softens.",
      "Drizzle with honey and scatter fresh thyme leaves."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Hummus and Egg Plate with Carrot, Cucumber, and Red Pepper (Non-Vegan Alt)",
    "newName": "Hummus and Egg Plate with Carrot, Cucumber, and Red Pepper (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Carrot, cut into sticks",
        "amount": "1/2"
      },
      {
        "name": "Cucumber, cut into sticks",
        "amount": "1/2"
      },
      {
        "name": "Egg, hard-boiled",
        "amount": "1"
      },
      {
        "name": "Hummus",
        "amount": "1/3 cup"
      },
      {
        "name": "Red bell pepper, cut into sticks",
        "amount": "1/2"
      }
    ],
    "expectedInstructions": [
      "Spoon hummus into a small bowl.",
      "Halve the hard-boiled egg and place alongside the hummus.",
      "Arrange carrot, cucumber, and red pepper sticks around the plate."
    ],
    "instructions": [
      "Spoon hummus into a small bowl.",
      "Halve the hard-boiled egg and place alongside the hummus.",
      "Arrange carrot, cucumber, and red pepper sticks around the plate."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Egg, hard-boiled. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Hummus with Carrot, Cucumber, and Red Pepper Sticks",
    "newName": "Hummus with Carrot, Cucumber, and Red Pepper Sticks",
    "expectedIngredients": [
      {
        "name": "Carrot, cut into sticks",
        "amount": "1/2"
      },
      {
        "name": "Cucumber, cut into sticks",
        "amount": "1/2"
      },
      {
        "name": "Hummus",
        "amount": "1/3 cup"
      },
      {
        "name": "Red bell pepper, cut into sticks",
        "amount": "1/2"
      }
    ],
    "expectedInstructions": [
      "Spoon hummus into a small bowl.",
      "Arrange carrot, cucumber, and red pepper sticks around the hummus.",
      "Serve for dipping."
    ],
    "instructions": [
      "Spoon hummus into a small bowl.",
      "Arrange carrot, cucumber, and red pepper sticks around the hummus.",
      "Serve for dipping."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Kale and White Bean Salad with Roasted Sweet Potato and Soft Egg",
    "newName": "Kale and White Bean Salad with Roasted Sweet Potato and Soft Egg",
    "expectedIngredients": [
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Kale, chopped",
        "amount": "2 cups"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Sweet potato, diced and roasted",
        "amount": "1/2 cup"
      },
      {
        "name": "White beans",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Massage chopped kale with olive oil and lemon juice for 1-2 minutes until softened.",
      "Toss in white beans and roasted sweet potato.",
      "Soft-boil the egg for 6-7 minutes, then halve.",
      "Top the salad with the soft-boiled egg."
    ],
    "instructions": [
      "Massage chopped kale with olive oil and lemon juice for 1-2 minutes until softened.",
      "Toss in white beans and roasted sweet potato.",
      "Soft-boil the egg for 6-7 minutes, then halve.",
      "Top the salad with the soft-boiled egg."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Sweet potato, diced and roasted. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans.",
        "This recipe has a soft-egg option; read the soft-egg cooking check before choosing a runny yolk."
      ],
      "cookingChecks": [
        "soft-egg",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.fda.gov/food/buy-store-serve-safe-food/what-you-need-know-about-egg-safety"
      ]
    }
  },
  {
    "name": "Kefir Berry Smoothie with Flaxseed",
    "newName": "Kefir Berry Smoothie with Flaxseed",
    "expectedIngredients": [
      {
        "name": "Banana",
        "amount": "1/2"
      },
      {
        "name": "Frozen mixed berries",
        "amount": "1/2 cup"
      },
      {
        "name": "Ground flaxseed",
        "amount": "1 tbsp"
      },
      {
        "name": "Kefir",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Combine kefir, frozen berries, banana, and flaxseed in a blender.",
      "Blend until smooth.",
      "If the tang is too strong, blend in a little extra banana or a splash of oat milk."
    ],
    "instructions": [
      "Combine kefir, frozen berries, banana, and flaxseed in a blender.",
      "Blend until smooth.",
      "If the tang is too strong, blend in a little extra banana or a splash of oat milk."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Follow frozen fruit packet instructions; some berries must be heated and cooled before being eaten."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Kefir Green Smoothie with Mango and Ginger",
    "newName": "Kefir Green Smoothie with Mango and Ginger",
    "expectedIngredients": [
      {
        "name": "Fresh ginger",
        "amount": "1/2 tsp"
      },
      {
        "name": "Kefir",
        "amount": "1 cup"
      },
      {
        "name": "Mango, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Spinach",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Combine kefir, mango, spinach, and ginger in a blender.",
      "Blend until smooth."
    ],
    "instructions": [
      "Combine kefir, mango, spinach, and ginger in a blender.",
      "Blend until smooth."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Lentil Soup with Turmeric and Ginger",
    "newName": "Lentil Soup with Turmeric and Ginger",
    "expectedIngredients": [
      {
        "name": "Carrot, diced",
        "amount": "1/2"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Lentils",
        "amount": "1/2 cup"
      },
      {
        "name": "Onion, diced",
        "amount": "1/4"
      },
      {
        "name": "Parsley, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      },
      {
        "name": "Vegetable broth",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Saute onion, carrot, and ginger in a pot over medium heat for 3-4 minutes.",
      "Add lentils, turmeric, and broth.",
      "Simmer for 20-25 minutes, until lentils are soft.",
      "Finish with chopped parsley before serving."
    ],
    "instructions": [
      "Use dried red split lentils for these timings; rinse them. Dice the onion and carrot and grate the ginger.",
      "Cook the onion, carrot and ginger in a saucepan over medium heat with a few tablespoons of the measured broth for about 3-4 minutes.",
      "Add the lentils, turmeric and remaining broth, bring to a gentle boil and lower the heat.",
      "Simmer for about 20-25 minutes, stirring occasionally, until the lentils are soft; add water if needed.",
      "Finish with the parsley and serve hot."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use dried red split lentils, rinsed, for the stated simmering times. Other lentil varieties may need longer and more liquid; follow the packet and cook until soft."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Lentil and Vegetable Curry with Brown Rice",
    "newName": "Lentil and Vegetable Curry with Brown Rice",
    "expectedIngredients": [
      {
        "name": "Bell pepper, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Carrot, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Cumin",
        "amount": "1/4 tsp"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Lentils",
        "amount": "1/2 cup"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      },
      {
        "name": "Vegetable broth",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Simmer lentils, carrot, and bell pepper with turmeric, cumin, ginger, and broth for 20 minutes, until lentils are soft.",
      "Stir in spinach and cook until wilted, about 2 minutes.",
      "Serve over cooked brown rice."
    ],
    "instructions": [
      "Use dried red split lentils for these timings and cooked brown rice. Rinse the lentils and dice the carrot and pepper.",
      "Combine the lentils, vegetables, turmeric, cumin, ginger and broth in a saucepan with about 1/4 cup of water.",
      "Bring to a gentle boil, then simmer over low-medium heat for about 20-25 minutes, stirring and adding water as necessary until the lentils are soft.",
      "Add the spinach for about 2 minutes until wilted. Serve over cooked brown rice, reheated until steaming hot throughout if chilled."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use dried red split lentils, rinsed, for the stated simmering times. Other lentil varieties may need longer and more liquid; follow the packet and cook until soft."
      ],
      "cookingChecks": [
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Loaded Quinoa Power Salad with Chickpeas, Roasted Vegetables, and Feta",
    "newName": "Loaded Quinoa Power Salad with Chickpeas, Roasted Vegetables, and Feta",
    "expectedIngredients": [
      {
        "name": "Chickpeas",
        "amount": "1/2 cup"
      },
      {
        "name": "Cooked quinoa",
        "amount": "3/4 cup"
      },
      {
        "name": "Cucumber, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Feta, crumbled",
        "amount": "30 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Roasted red pepper, sliced",
        "amount": "1/4 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Combine cooked quinoa, chickpeas, roasted red pepper, and cucumber in a bowl.",
      "Whisk olive oil, lemon juice, and turmeric together for the dressing.",
      "Pour dressing over the salad and toss to combine.",
      "Top with crumbled feta before serving."
    ],
    "instructions": [
      "Combine cooked quinoa, chickpeas, roasted red pepper, and cucumber in a bowl.",
      "Whisk olive oil, lemon juice, and turmeric together for the dressing.",
      "Pour dressing over the salad and toss to combine.",
      "Top with crumbled feta before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked quinoa, Roasted red pepper, sliced. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Mediterranean Loaded Chickpea Salad with Grilled Chicken and Feta",
    "newName": "Mediterranean Loaded Chickpea Salad with Grilled Chicken and Feta",
    "expectedIngredients": [
      {
        "name": "Chickpeas",
        "amount": "1/2 cup"
      },
      {
        "name": "Cucumber, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Feta, crumbled",
        "amount": "30 g"
      },
      {
        "name": "Grilled chicken breast, sliced",
        "amount": "100 g"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Parsley, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Red onion, sliced",
        "amount": "2 tbsp"
      },
      {
        "name": "Tomato, diced",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Combine chickpeas, tomato, cucumber, and red onion in a bowl.",
      "Dress with olive oil, lemon juice, and parsley.",
      "Top with sliced grilled chicken and crumbled feta."
    ],
    "instructions": [
      "Combine chickpeas, tomato, cucumber, and red onion in a bowl.",
      "Dress with olive oil, lemon juice, and parsley.",
      "Top with sliced grilled chicken and crumbled feta."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Grilled chicken breast, sliced. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Miso Ginger Soup with Shrimp, Bok Choy, and Soba Noodles (Non-Vegan Alt)",
    "newName": "Miso Ginger Soup with Shrimp, Bok Choy, and Soba Noodles (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Bok choy, chopped",
        "amount": "1 cup"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Miso paste",
        "amount": "1 tbsp"
      },
      {
        "name": "Scallion, sliced",
        "amount": "1 tbsp"
      },
      {
        "name": "Shrimp, peeled",
        "amount": "100 g"
      },
      {
        "name": "Soba noodles, cooked",
        "amount": "1/2 cup"
      },
      {
        "name": "Vegetable broth",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Simmer broth with ginger for 5 minutes.",
      "Add shrimp, bok choy, and cooked soba noodles, and simmer for 3-4 minutes until shrimp is pink.",
      "Remove from heat and stir in miso paste until dissolved.",
      "Top with sliced scallion before serving."
    ],
    "instructions": [
      "Use peeled, deveined, fully thawed shrimp and soba noodles already cooked according to their packet.",
      "Bring the broth and ginger to a gentle simmer in a saucepan and cook for about 5 minutes.",
      "Add the shrimp, bok choy and cooked noodles. Simmer for about 3-5 minutes, until the bok choy is tender and the shrimp is opaque throughout; use the shrimp cooking check below.",
      "Remove from the heat and stir in the miso until dissolved. Add the scallion and serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Soba noodles, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use peeled, deveined, fully thawed shrimp for the stated timings."
      ],
      "cookingChecks": [
        "shrimp",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Miso Ginger Soup with Tofu, Bok Choy, and Soba Noodles",
    "newName": "Miso Ginger Soup with Tofu, Bok Choy, and Soba Noodles",
    "expectedIngredients": [
      {
        "name": "Bok choy, chopped",
        "amount": "1 cup"
      },
      {
        "name": "Firm tofu, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Miso paste",
        "amount": "1 tbsp"
      },
      {
        "name": "Scallion, sliced",
        "amount": "1 tbsp"
      },
      {
        "name": "Soba noodles, cooked",
        "amount": "1/2 cup"
      },
      {
        "name": "Vegetable broth",
        "amount": "2 cups"
      }
    ],
    "expectedInstructions": [
      "Simmer broth with ginger for 5 minutes.",
      "Add tofu, bok choy, and cooked soba noodles, and simmer for 2-3 minutes.",
      "Remove from heat and stir in miso paste until dissolved.",
      "Top with sliced scallion before serving."
    ],
    "instructions": [
      "Simmer broth with ginger for 5 minutes.",
      "Add tofu, bok choy, and cooked soba noodles, and simmer for 2-3 minutes.",
      "Remove from heat and stir in miso paste until dissolved.",
      "Top with sliced scallion before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Soba noodles, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Mixed Berries with Walnuts",
    "newName": "Mixed Berries with Walnuts",
    "expectedIngredients": [
      {
        "name": "Mixed berries (strawberry, blueberry, raspberry)",
        "amount": "1 cup"
      },
      {
        "name": "Walnuts",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Combine mixed berries and walnuts in a small bowl.",
      "Serve immediately."
    ],
    "instructions": [
      "Combine mixed berries and walnuts in a small bowl.",
      "Serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Mixed Berries with Walnuts and Greek Yogurt (Non-Vegan Alt)",
    "newName": "Mixed Berries with Walnuts and Greek Yogurt (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Greek yogurt",
        "amount": "2 tbsp"
      },
      {
        "name": "Mixed berries",
        "amount": "1 cup"
      },
      {
        "name": "Walnuts",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Combine mixed berries and walnuts in a small bowl.",
      "Top with a spoonful of Greek yogurt."
    ],
    "instructions": [
      "Combine mixed berries and walnuts in a small bowl.",
      "Top with a spoonful of Greek yogurt."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Overnight Oats with Cinnamon, Walnuts, and Raspberries",
    "newName": "Overnight Oats with Cinnamon, Walnuts, and Raspberries",
    "expectedIngredients": [
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Milk or plant milk",
        "amount": "3/4 cup"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tbsp"
      },
      {
        "name": "Raspberries",
        "amount": "1/2 cup"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      },
      {
        "name": "Walnuts, chopped",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Combine oats, milk, and cinnamon in a jar.",
      "Stir well, cover, and refrigerate overnight.",
      "Top with walnuts, raspberries, and pomegranate seeds just before eating."
    ],
    "instructions": [
      "Combine oats, milk, and cinnamon in a jar.",
      "Stir well, cover, and refrigerate overnight.",
      "Top with walnuts, raspberries, and pomegranate seeds just before eating."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Overnight Oats with Milk, Honey, Walnuts, and Raspberries (Non-Vegan Alt)",
    "newName": "Overnight Oats with Milk, Honey, Walnuts, and Raspberries (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tbsp"
      },
      {
        "name": "Raspberries",
        "amount": "1/2 cup"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      },
      {
        "name": "Walnuts, chopped",
        "amount": "2 tbsp"
      },
      {
        "name": "Whole milk",
        "amount": "3/4 cup"
      }
    ],
    "expectedInstructions": [
      "Combine oats, whole milk, honey, and cinnamon in a jar.",
      "Stir well, cover, and refrigerate overnight.",
      "Top with walnuts, raspberries, and pomegranate seeds before eating."
    ],
    "instructions": [
      "Combine oats, whole milk, honey, and cinnamon in a jar.",
      "Stir well, cover, and refrigerate overnight.",
      "Top with walnuts, raspberries, and pomegranate seeds before eating."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Allow the refrigeration time stated in the directions as well as hands-on preparation; these recipes are not ready immediately after mixing."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Peanut Butter and Banana Rice Cakes",
    "newName": "Peanut Butter and Banana Rice Cakes",
    "expectedIngredients": [
      {
        "name": "Banana, sliced",
        "amount": "1/2"
      },
      {
        "name": "Brown rice cakes",
        "amount": "2"
      },
      {
        "name": "Cinnamon",
        "amount": "pinch"
      },
      {
        "name": "Peanut butter",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Spread peanut butter evenly over each rice cake.",
      "Top with banana slices.",
      "Dust lightly with cinnamon."
    ],
    "instructions": [
      "Spread peanut butter evenly over each rice cake.",
      "Top with banana slices.",
      "Dust lightly with cinnamon."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Beet, Orange, and Avocado Salad with Feta and Walnuts",
    "newName": "Roasted Beet, Orange, and Avocado Salad with Feta and Walnuts",
    "expectedIngredients": [
      {
        "name": "Apple cider vinegar",
        "amount": "1 tsp"
      },
      {
        "name": "Avocado, sliced",
        "amount": "1/2"
      },
      {
        "name": "Beets, roasted and sliced",
        "amount": "1/2 cup"
      },
      {
        "name": "Feta, crumbled",
        "amount": "30 g"
      },
      {
        "name": "Honey",
        "amount": "1/2 tsp"
      },
      {
        "name": "Mixed greens",
        "amount": "2 cups"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Orange segments",
        "amount": "1/2 cup"
      },
      {
        "name": "Red onion, thinly sliced",
        "amount": "2 tbsp"
      },
      {
        "name": "Walnuts, toasted",
        "amount": "2 tbsp"
      }
    ],
    "expectedInstructions": [
      "Lay mixed greens in a wide bowl.",
      "Arrange roasted beet slices, orange segments, and avocado wedges on top.",
      "Scatter thin red onion over the salad.",
      "Whisk olive oil, apple cider vinegar, and honey, then drizzle over the salad.",
      "Finish with crumbled feta and toasted walnuts."
    ],
    "instructions": [
      "Lay mixed greens in a wide bowl.",
      "Arrange roasted beet slices, orange segments, and avocado wedges on top.",
      "Scatter thin red onion over the salad.",
      "Whisk olive oil, apple cider vinegar, and honey, then drizzle over the salad.",
      "Finish with crumbled feta and toasted walnuts."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Beets, roasted and sliced. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Pumpkin Seeds with Ginger",
    "newName": "Roasted Pumpkin Seeds with Ginger",
    "expectedIngredients": [
      {
        "name": "Ground ginger",
        "amount": "1/4 tsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Pumpkin seeds",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 180C/350F.",
      "Toss pumpkin seeds with olive oil and ground ginger.",
      "Spread on a baking sheet and roast for 12-15 minutes, until golden."
    ],
    "instructions": [
      "Preheat oven to 180C/350F.",
      "Toss pumpkin seeds with olive oil and ground ginger.",
      "Spread on a baking sheet and roast for 12-15 minutes, until golden."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Pumpkin Seeds with Ginger and Parmesan (Non-Vegan Alt)",
    "newName": "Roasted Pumpkin Seeds with Ginger and Parmesan (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Ground ginger",
        "amount": "1/4 tsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Parmesan, grated",
        "amount": "2 tbsp"
      },
      {
        "name": "Pumpkin seeds",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 180C/350F.",
      "Toss pumpkin seeds with olive oil and ground ginger.",
      "Spread on a baking sheet and roast for 12-15 minutes, until golden.",
      "Toss with grated parmesan while still warm."
    ],
    "instructions": [
      "Preheat oven to 180C/350F.",
      "Toss pumpkin seeds with olive oil and ground ginger.",
      "Spread on a baking sheet and roast for 12-15 minutes, until golden.",
      "Toss with grated parmesan while still warm."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Vegetable and Chicken Curry (Non-Vegan Alt)",
    "newName": "Roasted Vegetable and Chicken Curry (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Carrot, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Cauliflower florets",
        "amount": "1/2 cup"
      },
      {
        "name": "Chicken thighs, diced",
        "amount": "150 g"
      },
      {
        "name": "Coconut milk",
        "amount": "1/2 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Red pepper, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Brown chicken thighs in a pan, about 5 minutes.",
      "Preheat oven to 200C/400F and roast carrot, cauliflower, and red pepper with a little olive oil for 20 minutes.",
      "Simmer chicken, turmeric, and coconut milk together for 10 minutes, until chicken is cooked through.",
      "Stir in the roasted vegetables and combine."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Cut the carrot, cauliflower and pepper into small, evenly sized pieces; cut boneless chicken thighs into roughly 2 cm pieces.",
      "Toss the vegetables with about half the olive oil and roast for about 20-25 minutes until tender, turning once.",
      "Heat the remaining oil in a non-stick frying pan over medium heat. Turn the chicken for about 5-6 minutes until browned on the outside.",
      "Add the turmeric and coconut milk and simmer for about 10-15 minutes, adding a little water if needed. Check the largest chicken pieces using the poultry cooking check below.",
      "Fold in the roasted vegetables, stir until hot throughout and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Roasted Vegetable and Chickpea Curry",
    "newName": "Roasted Vegetable and Chickpea Curry",
    "expectedIngredients": [
      {
        "name": "Carrot, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Cauliflower florets",
        "amount": "1/2 cup"
      },
      {
        "name": "Chickpeas",
        "amount": "1 cup"
      },
      {
        "name": "Coconut milk",
        "amount": "1/2 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Red pepper, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F and roast carrot, cauliflower, and red pepper with a little olive oil for 20 minutes.",
      "Simmer chickpeas, turmeric, and coconut milk in a pan for 5 minutes.",
      "Add the roasted vegetables to the curry sauce and stir to combine."
    ],
    "instructions": [
      "Preheat oven to 200C/400F and roast carrot, cauliflower, and red pepper with a little olive oil for 20 minutes.",
      "Simmer chickpeas, turmeric, and coconut milk in a pan for 5 minutes.",
      "Add the roasted vegetables to the curry sauce and stir to combine."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Roasted Vegetable and Farro Bowl with Chickpeas and Tahini",
    "newName": "Roasted Vegetable and Farro Bowl with Chickpeas and Tahini",
    "expectedIngredients": [
      {
        "name": "Bell pepper, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Chickpeas",
        "amount": "1/2 cup"
      },
      {
        "name": "Farro, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Fresh herbs, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Tahini",
        "amount": "1 tbsp"
      },
      {
        "name": "Zucchini, diced",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Toss zucchini, bell pepper, and chickpeas with olive oil.",
      "Roast at 200C/400F for 20 minutes, until vegetables are tender.",
      "Spoon cooked farro into a bowl and top with the roasted vegetables and chickpeas.",
      "Drizzle with tahini and finish with fresh herbs."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Use farro already cooked according to its packet and drained ready-cooked chickpeas.",
      "Toss the chopped zucchini, pepper and chickpeas with the olive oil; spread in one layer on a baking tray.",
      "Roast for about 20-25 minutes until tender, turning once.",
      "Warm the farro until steaming hot throughout if using chilled cooked farro, and spoon into a bowl.",
      "Add the roasted vegetables and chickpeas, drizzle with the tahini and scatter over the herbs."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Farro, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Roasted Vegetable and Farro Bowl with Grilled Chicken and Tahini (Non-Vegan Alt)",
    "newName": "Roasted Vegetable and Farro Bowl with Grilled Chicken and Tahini (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Bell pepper, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Farro, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Fresh herbs, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Grilled chicken, sliced",
        "amount": "100 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Tahini",
        "amount": "1 tbsp"
      },
      {
        "name": "Zucchini, diced",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Toss zucchini and bell pepper with olive oil and roast at 200C/400F for 20 minutes.",
      "Spoon cooked farro into a bowl and top with roasted vegetables.",
      "Add sliced grilled chicken on top.",
      "Drizzle with tahini and finish with fresh herbs."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Use farro and grilled chicken that have already been fully cooked; these steps do not cook raw chicken.",
      "Toss the chopped zucchini and pepper with the olive oil and roast in one layer for about 20-25 minutes until tender, turning once.",
      "If serving warm, thoroughly reheat the cooked farro and chicken, using the reheating check below.",
      "Put the farro in a bowl, add the roasted vegetables and sliced cooked chicken, then finish with tahini and herbs."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Grilled chicken, sliced, Farro, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Salmon and Avocado Breakfast Bowl",
    "newName": "Salmon and Avocado Breakfast Bowl",
    "expectedIngredients": [
      {
        "name": "Avocado, sliced",
        "amount": "1/2"
      },
      {
        "name": "Cooked quinoa",
        "amount": "3/4 cup"
      },
      {
        "name": "Cucumber, sliced",
        "amount": "1/4 cup"
      },
      {
        "name": "Pickled red onion",
        "amount": "1 tbsp"
      },
      {
        "name": "Salmon, cooked and flaked",
        "amount": "100 g"
      },
      {
        "name": "Sesame seeds",
        "amount": "1 tsp"
      }
    ],
    "expectedInstructions": [
      "Spoon cooked quinoa into a bowl.",
      "Flake salmon over the quinoa.",
      "Arrange avocado and cucumber slices on top.",
      "Scatter pickled red onion and sesame seeds before serving."
    ],
    "instructions": [
      "Spoon cooked quinoa into a bowl.",
      "Flake salmon over the quinoa.",
      "Arrange avocado and cucumber slices on top.",
      "Scatter pickled red onion and sesame seeds before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked quinoa, Salmon, cooked and flaked. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Sardine and Arugula Salad with White Beans and Olive Oil",
    "newName": "Sardine and Arugula Salad with White Beans and Olive Oil",
    "expectedIngredients": [
      {
        "name": "Arugula",
        "amount": "2 cups"
      },
      {
        "name": "Canned sardines",
        "amount": "1 can (about 90 g)"
      },
      {
        "name": "Cherry tomatoes, halved",
        "amount": "6"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "White beans",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Combine arugula, white beans, and halved cherry tomatoes in a bowl.",
      "Add sardines on top.",
      "Dress with olive oil and lemon juice, then toss gently."
    ],
    "instructions": [
      "Combine arugula, white beans, and halved cherry tomatoes in a bowl.",
      "Add sardines on top.",
      "Dress with olive oil and lemon juice, then toss gently."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Shrimp and Avocado Rice Bowl with Lime",
    "newName": "Shrimp and Avocado Rice Bowl with Lime",
    "expectedIngredients": [
      {
        "name": "Avocado, diced",
        "amount": "1/2"
      },
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Cilantro, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Cucumber, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Lime juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Shrimp, peeled",
        "amount": "150 g"
      }
    ],
    "expectedInstructions": [
      "Saute shrimp in olive oil with half the lime juice until pink and cooked through, about 4 minutes.",
      "Spoon cooked brown rice into a bowl.",
      "Top with shrimp, diced avocado, and cucumber.",
      "Finish with cilantro and remaining lime juice."
    ],
    "instructions": [
      "Use cooked brown rice and peeled, deveined, fully thawed shrimp. Wash and dice the cucumber and avocado.",
      "Heat the olive oil in a non-stick frying pan over medium heat. Add the shrimp and half the lime juice; cook for about 2-3 minutes per side until opaque throughout, using the shrimp check below.",
      "If using chilled rice for a warm bowl, reheat it until steaming hot throughout and put it in a bowl.",
      "Add the cooked shrimp, avocado and cucumber, then finish with the cilantro and remaining lime juice. Serve immediately."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use peeled, deveined, fully thawed shrimp for the stated timings."
      ],
      "cookingChecks": [
        "shrimp",
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Silken Tofu Berry Parfait (Yogurt-Free)",
    "newName": "Silken Tofu Berry Parfait (Yogurt-Free)",
    "expectedIngredients": [
      {
        "name": "Blueberries",
        "amount": "1/2 cup"
      },
      {
        "name": "Ground flaxseed",
        "amount": "1 tbsp"
      },
      {
        "name": "Maple syrup",
        "amount": "1 tsp"
      },
      {
        "name": "Silken tofu",
        "amount": "1/2 cup"
      },
      {
        "name": "Vanilla extract",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Blend silken tofu with maple syrup and vanilla until completely smooth.",
      "Spoon a layer of the tofu mixture into a glass.",
      "Add a layer of blueberries and flaxseed.",
      "Repeat layers until the glass is full."
    ],
    "instructions": [
      "Blend silken tofu with maple syrup and vanilla until completely smooth.",
      "Spoon a layer of the tofu mixture into a glass.",
      "Add a layer of blueberries and flaxseed.",
      "Repeat layers until the glass is full."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use silken tofu suitable for eating as sold. If the packet requires cooking, follow it and cool the tofu safely before blending."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Slow-Cooked Beef and Vegetable Stew with Turmeric",
    "newName": "Slow-Cooked Beef and Vegetable Stew with Turmeric",
    "expectedIngredients": [
      {
        "name": "Beef or vegetable broth",
        "amount": "1 1/2 cups"
      },
      {
        "name": "Carrot, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Celery, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Lean beef, cubed",
        "amount": "200 g"
      },
      {
        "name": "Peas",
        "amount": "1/4 cup"
      },
      {
        "name": "Tomato, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Brown the beef cubes in a pot over medium-high heat, about 5 minutes.",
      "Add carrot, celery, turmeric, tomato, and broth.",
      "Cover and simmer for 45-60 minutes (or slow-cook for longer), until the beef is tender.",
      "Stir in peas during the last 5 minutes to keep their color."
    ],
    "instructions": [
      "Cut the beef into small, even pieces about 2 cm wide and dice the carrot and celery.",
      "Heat a heavy non-stick saucepan over medium-high heat. Brown the beef on several sides for about 5 minutes, working in batches if needed; use a splash of broth if it starts to stick.",
      "Add the carrot, celery, turmeric, tomato and remaining broth. Bring to a gentle bubble, cover and lower the heat.",
      "Simmer gently until the beef is tender enough to break with a fork. Start checking after about 60 minutes; a tougher cut may need 90-120 minutes. Stir and top up with water if the liquid reduces too far.",
      "Use the whole-cut beef cooking check below, add the peas for the last 5 minutes and serve hot. These directions describe a hob method, not a timed slow-cooker programme."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "whole-cut-meat",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Smoked Salmon and Avocado Toast with Everything Seasoning",
    "newName": "Smoked Salmon and Avocado Toast with Everything Seasoning",
    "expectedIngredients": [
      {
        "name": "Avocado",
        "amount": "1/2"
      },
      {
        "name": "Everything bagel seasoning",
        "amount": "1/2 tsp"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tsp"
      },
      {
        "name": "Smoked salmon",
        "amount": "40 g"
      },
      {
        "name": "Whole grain bread",
        "amount": "1 slice"
      }
    ],
    "expectedInstructions": [
      "Toast the bread.",
      "Mash avocado with lemon juice and spread onto the toast.",
      "Layer smoked salmon on top.",
      "Finish with a sprinkle of everything seasoning."
    ],
    "instructions": [
      "Toast the bread.",
      "Mash avocado with lemon juice and spread onto the toast.",
      "Layer smoked salmon on top.",
      "Finish with a sprinkle of everything seasoning."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use ready-to-eat cooked/deli or smoked products as specified and follow their pack directions and use-by date; do not substitute raw meat or raw fish into an assembly-only method."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Smoked Salmon and Cucumber Bites with Dill",
    "newName": "Smoked Salmon and Cucumber Bites with Dill",
    "expectedIngredients": [
      {
        "name": "Cucumber, sliced into rounds",
        "amount": "1/2"
      },
      {
        "name": "Fresh dill sprigs",
        "amount": "6"
      },
      {
        "name": "Lemon wedge",
        "amount": "1"
      },
      {
        "name": "Smoked salmon",
        "amount": "60 g"
      }
    ],
    "expectedInstructions": [
      "Arrange cucumber rounds on a plate.",
      "Top each round with a small piece of smoked salmon.",
      "Add a sprig of dill to each.",
      "Finish with a squeeze of lemon."
    ],
    "instructions": [
      "Arrange cucumber rounds on a plate.",
      "Top each round with a small piece of smoked salmon.",
      "Add a sprig of dill to each.",
      "Finish with a squeeze of lemon."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use ready-to-eat cooked/deli or smoked products as specified and follow their pack directions and use-by date; do not substitute raw meat or raw fish into an assembly-only method."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Soft-Boiled Eggs with Turmeric Roasted Asparagus",
    "newName": "Soft-Boiled Eggs with Turmeric Roasted Asparagus",
    "expectedIngredients": [
      {
        "name": "Asparagus",
        "amount": "8 spears"
      },
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Toss asparagus with olive oil, turmeric, and black pepper.",
      "Roast at 200C/400F for 10-12 minutes until tender.",
      "Meanwhile, soft-boil eggs for 6-7 minutes, then transfer to cold water.",
      "Peel and halve the eggs, serve alongside the roasted asparagus."
    ],
    "instructions": [
      "Toss asparagus with olive oil, turmeric, and black pepper.",
      "Roast at 200C/400F for 10-12 minutes until tender.",
      "Meanwhile, soft-boil eggs for 6-7 minutes, then transfer to cold water.",
      "Peel and halve the eggs, serve alongside the roasted asparagus."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "This recipe has a soft-egg option; read the soft-egg cooking check before choosing a runny yolk."
      ],
      "cookingChecks": [
        "soft-egg",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.fda.gov/food/buy-store-serve-safe-food/what-you-need-know-about-egg-safety"
      ]
    }
  },
  {
    "name": "Spinach and Mushroom Omelet with Olive Oil",
    "newName": "Spinach and Mushroom Omelet with Olive Oil",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Microgreens",
        "amount": "small handful"
      },
      {
        "name": "Mushrooms, sliced",
        "amount": "1/2 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Radish, thinly sliced",
        "amount": "2-3 slices"
      },
      {
        "name": "Salt",
        "amount": "pinch"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Heat olive oil in a pan over medium heat and saute mushrooms for 2-3 minutes.",
      "Add spinach and cook until wilted, about 1 minute.",
      "Pour in whisked eggs and cook on low heat until just set.",
      "Fold the omelet and slide onto a plate.",
      "Top with radish, pomegranate seeds, and microgreens before serving."
    ],
    "instructions": [
      "Heat olive oil in a pan over medium heat and saute mushrooms for 2-3 minutes.",
      "Add spinach and cook until wilted, about 1 minute.",
      "Pour in whisked eggs and cook on low heat until just set.",
      "Fold the omelet and slide onto a plate.",
      "Top with radish, pomegranate seeds, and microgreens before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Stuffed Bell Peppers with Quinoa, Black Beans, and Corn",
    "newName": "Stuffed Bell Peppers with Quinoa, Black Beans, and Corn",
    "expectedIngredients": [
      {
        "name": "Bell peppers, halved",
        "amount": "2"
      },
      {
        "name": "Black beans",
        "amount": "1/2 cup"
      },
      {
        "name": "Cooked quinoa",
        "amount": "1 cup"
      },
      {
        "name": "Corn kernels",
        "amount": "1/2 cup"
      },
      {
        "name": "Tomato, diced",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 190C/375F.",
      "Mix cooked quinoa with black beans, corn, and diced tomato.",
      "Spoon the mixture into the halved bell peppers.",
      "Place peppers in a baking dish and bake for 25-30 minutes, until peppers soften."
    ],
    "instructions": [
      "Preheat oven to 190C/375F.",
      "Mix cooked quinoa with black beans, corn, and diced tomato.",
      "Spoon the mixture into the halved bell peppers.",
      "Place peppers in a baking dish and bake for 25-30 minutes, until peppers soften."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Cooked quinoa. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Sweet Potato and Black Bean Breakfast Hash",
    "newName": "Sweet Potato and Black Bean Breakfast Hash",
    "expectedIngredients": [
      {
        "name": "Bell pepper, diced",
        "amount": "1/2"
      },
      {
        "name": "Black beans",
        "amount": "1/2 cup"
      },
      {
        "name": "Cilantro, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Egg",
        "amount": "1"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Salt and pepper",
        "amount": "to taste"
      },
      {
        "name": "Sweet potato, diced",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Roast diced sweet potato with a little olive oil at 200C/400F for 20 minutes, until tender.",
      "Heat remaining olive oil in a pan and saute bell pepper for 2-3 minutes.",
      "Add roasted sweet potato and black beans, cook until warmed through.",
      "Fry an egg in a separate pan to your preference.",
      "Top the hash with the fried egg and fresh cilantro."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Use drained, ready-cooked black beans and sweet potato cut into small, roughly 1-2 cm cubes.",
      "Toss the sweet potato with about half the olive oil and roast for about 20-25 minutes until fork-tender, turning once.",
      "Heat the remaining oil in a non-stick frying pan over medium heat. Cook the pepper for about 3-4 minutes, then stir in the roasted sweet potato and beans until hot throughout.",
      "In a good non-stick pan over low-medium heat, fry the egg until the white and yolk are firm; the whole-egg cooking check below explains the endpoint.",
      "Top the hash with the cooked egg and cilantro and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "whole-egg",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Sweet Potato, Black Bean, and Grilled Chicken Buddha Bowl",
    "newName": "Sweet Potato, Black Bean, and Grilled Chicken Buddha Bowl",
    "expectedIngredients": [
      {
        "name": "Avocado, sliced",
        "amount": "1/2"
      },
      {
        "name": "Black beans",
        "amount": "1/2 cup"
      },
      {
        "name": "Brown rice, cooked",
        "amount": "3/4 cup"
      },
      {
        "name": "Grilled chicken, sliced",
        "amount": "100 g"
      },
      {
        "name": "Red cabbage, shredded",
        "amount": "1/4 cup"
      },
      {
        "name": "Sweet potato, diced and roasted",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Spoon cooked brown rice into a bowl.",
      "Arrange roasted sweet potato, black beans, and sliced grilled chicken on top.",
      "Add avocado slices and shredded red cabbage.",
      "Serve warm."
    ],
    "instructions": [
      "Spoon cooked brown rice into a bowl.",
      "Arrange roasted sweet potato, black beans, and sliced grilled chicken on top.",
      "Add avocado slices and shredded red cabbage.",
      "Serve warm."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Grilled chicken, sliced, Sweet potato, diced and roasted, Brown rice, cooked. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "rice-storage",
        "reheating",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures",
        "https://www.gov.uk/government/publications/home-food-fact-checker/home-food-fact-checker"
      ]
    }
  },
  {
    "name": "Tempeh and Broccoli Stir-Fry with Ginger",
    "newName": "Tempeh and Broccoli Stir-Fry with Ginger",
    "expectedIngredients": [
      {
        "name": "Broccoli florets",
        "amount": "1 cup"
      },
      {
        "name": "Carrot, sliced",
        "amount": "1/2"
      },
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Garlic, minced",
        "amount": "1 clove"
      },
      {
        "name": "Tamari",
        "amount": "1 tbsp"
      },
      {
        "name": "Tempeh, sliced",
        "amount": "150 g"
      }
    ],
    "expectedInstructions": [
      "Pan-fry tempeh slices until browned on both sides, about 3-4 minutes per side, then remove from the pan.",
      "Stir-fry broccoli and carrot in the same pan for 3-4 minutes.",
      "Add ginger and garlic, and stir-fry for 30 seconds.",
      "Return tempeh to the pan with tamari and toss to combine."
    ],
    "instructions": [
      "Pan-fry tempeh slices until browned on both sides, about 3-4 minutes per side, then remove from the pan.",
      "Stir-fry broccoli and carrot in the same pan for 3-4 minutes.",
      "Add ginger and garlic, and stir-fry for 30 seconds.",
      "Return tempeh to the pan with tamari and toss to combine."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Tuna and White Bean Salad with Olive Oil",
    "newName": "Tuna and White Bean Salad with Olive Oil",
    "expectedIngredients": [
      {
        "name": "Canned tuna, drained",
        "amount": "1 can (about 120 g)"
      },
      {
        "name": "Lemon juice",
        "amount": "1 tbsp"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Parsley, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Red onion, thinly sliced",
        "amount": "2 tbsp"
      },
      {
        "name": "White beans",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Combine drained tuna, white beans, red onion, and parsley in a bowl.",
      "Dress with olive oil and lemon juice.",
      "Toss gently to combine and serve."
    ],
    "instructions": [
      "Combine drained tuna, white beans, red onion, and parsley in a bowl.",
      "Dress with olive oil and lemon juice.",
      "Toss gently to combine and serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turkey Chili with Kidney Beans, Bell Peppers, and Avocado",
    "newName": "Turkey Chili with Kidney Beans, Bell Peppers, and Avocado",
    "expectedIngredients": [
      {
        "name": "Avocado, diced",
        "amount": "1/2"
      },
      {
        "name": "Bell peppers, diced",
        "amount": "1/2 cup"
      },
      {
        "name": "Chili powder",
        "amount": "1 tsp"
      },
      {
        "name": "Cilantro, chopped",
        "amount": "1 tbsp"
      },
      {
        "name": "Cumin",
        "amount": "1/2 tsp"
      },
      {
        "name": "Ground turkey",
        "amount": "150 g"
      },
      {
        "name": "Kidney beans",
        "amount": "1/2 cup"
      },
      {
        "name": "Tomato, diced",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Brown ground turkey in a pot over medium heat, about 5 minutes.",
      "Add kidney beans, bell peppers, tomato, chili powder, and cumin.",
      "Simmer for 20 minutes, until thickened.",
      "Top with diced avocado and cilantro before serving."
    ],
    "instructions": [
      "Use canned kidney beans, drained and rinsed; dice the pepper, tomato and avocado.",
      "Brown the ground turkey in a non-stick saucepan over medium heat for about 6-8 minutes, breaking up clumps.",
      "Add the beans, pepper, tomato, chili powder and cumin with a splash of water if needed. Bring to a gentle simmer.",
      "Simmer on low for about 20 minutes, stirring occasionally, until the pepper is tender. Check the turkey using the poultry cooking check below.",
      "Serve topped with the avocado and cilantro."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans.",
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Turkey Sausage and Spinach Scramble",
    "newName": "Turkey Sausage and Spinach Scramble",
    "expectedIngredients": [
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Ground turkey sausage",
        "amount": "100 g"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Heat olive oil in a pan and brown the turkey sausage, breaking it into crumbles, about 5 minutes.",
      "Add spinach and cook until wilted.",
      "Pour in whisked eggs and scramble until just set."
    ],
    "instructions": [
      "Use raw turkey sausage and remove its casing if necessary. Beat the eggs in a bowl and wash the spinach.",
      "Heat the olive oil in a non-stick frying pan over medium heat. Add the sausage and break into small pieces; stir for about 6-8 minutes.",
      "Check the turkey using the poultry cooking check below, then stir in the spinach until wilted.",
      "Reduce to low-medium, add the eggs and stir for about 2-4 minutes until the egg is set with no liquid parts.",
      "Serve immediately. If the sausage is already cooked, follow its packet directions before adding it."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Turkey and Avocado Wrap on Whole Grain Tortilla with Roasted Peppers",
    "newName": "Turkey and Avocado Wrap on Whole Grain Tortilla with Roasted Peppers",
    "expectedIngredients": [
      {
        "name": "Avocado, mashed",
        "amount": "1/2"
      },
      {
        "name": "Roasted red pepper, sliced",
        "amount": "1/4 cup"
      },
      {
        "name": "Spinach",
        "amount": "1/2 cup"
      },
      {
        "name": "Turkey breast, sliced",
        "amount": "80 g"
      },
      {
        "name": "Whole grain tortilla",
        "amount": "1"
      }
    ],
    "expectedInstructions": [
      "Spread mashed avocado over the tortilla.",
      "Layer sliced turkey, spinach, and roasted red pepper on top.",
      "Roll the tortilla tightly, tucking in the sides.",
      "Slice in half to serve."
    ],
    "instructions": [
      "Spread mashed avocado over the tortilla.",
      "Layer sliced turkey, spinach, and roasted red pepper on top.",
      "Roll the tortilla tightly, tucking in the sides.",
      "Slice in half to serve."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Roasted red pepper, sliced. Cook them separately using their packet directions, or use a suitable ready-cooked product.",
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Turkey and Cucumber Roll-Ups with Mustard",
    "newName": "Turkey and Cucumber Roll-Ups with Mustard",
    "expectedIngredients": [
      {
        "name": "Cucumber, cut into sticks",
        "amount": "1"
      },
      {
        "name": "Sliced turkey breast",
        "amount": "6 slices"
      },
      {
        "name": "Whole grain mustard",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Spread a thin layer of mustard on each turkey slice.",
      "Wrap a turkey slice around each cucumber stick.",
      "Secure with a toothpick if needed."
    ],
    "instructions": [
      "Spread a thin layer of mustard on each turkey slice.",
      "Wrap a turkey slice around each cucumber stick.",
      "Secure with a toothpick if needed."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use ready-to-eat cooked/deli or smoked products as specified and follow their pack directions and use-by date; do not substitute raw meat or raw fish into an assembly-only method."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turmeric Chicken Thighs with Steamed Broccoli and Charred Lemon",
    "newName": "Turmeric Chicken Thighs with Steamed Broccoli and Charred Lemon",
    "expectedIngredients": [
      {
        "name": "Broccoli florets",
        "amount": "1 cup"
      },
      {
        "name": "Chicken thighs",
        "amount": "2"
      },
      {
        "name": "Garlic, minced",
        "amount": "1 clove"
      },
      {
        "name": "Lemon, halved",
        "amount": "1"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Marinate chicken thighs in turmeric, garlic, and olive oil for at least 10 minutes.",
      "Pan-sear or bake the chicken until cooked through, about 6-8 minutes per side if pan-searing.",
      "Steam broccoli florets for 4-5 minutes until tender.",
      "In the same pan used for the chicken, char the lemon halves cut-side down for 1-2 minutes.",
      "Serve the chicken with broccoli and charred lemon."
    ],
    "instructions": [
      "Use boneless chicken thighs, opening them out to an even thickness. Mix with the turmeric, garlic and olive oil and marinate in the fridge for about 10 minutes.",
      "Heat a non-stick frying pan over medium heat and pan-cook the chicken for about 6-8 minutes per side.",
      "Check its thickest part using the poultry cooking check below; continue cooking if necessary rather than relying on the timer.",
      "Steam the broccoli for about 4-5 minutes until tender. Once the chicken is safely cooked, use the pan to char the lemon cut-side down for about 1-2 minutes.",
      "Serve the cooked chicken with the broccoli and lemon; these directions use the pan method rather than an unspecified oven alternative."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use thawed poultry. Thighs are boneless unless the ingredient list explicitly says bone-in; keep raw poultry and its utensils separate from ready-to-eat ingredients."
      ],
      "cookingChecks": [
        "poultry",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Turmeric Deviled Eggs",
    "newName": "Turmeric Deviled Eggs",
    "expectedIngredients": [
      {
        "name": "Eggs, hard-boiled",
        "amount": "4"
      },
      {
        "name": "Mayonnaise (or Greek yogurt)",
        "amount": "2 tbsp"
      },
      {
        "name": "Paprika",
        "amount": "pinch"
      },
      {
        "name": "Turmeric",
        "amount": "1/4 tsp"
      }
    ],
    "expectedInstructions": [
      "Halve the hard-boiled eggs and scoop out the yolks.",
      "Mash yolks with mayonnaise (or Greek yogurt) and turmeric until smooth.",
      "Spoon the mixture back into the egg whites.",
      "Dust with paprika before serving."
    ],
    "instructions": [
      "Halve the hard-boiled eggs and scoop out the yolks.",
      "Mash yolks with mayonnaise (or Greek yogurt) and turmeric until smooth.",
      "Spoon the mixture back into the egg whites.",
      "Dust with paprika before serving."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Have these ingredients already cooked before you start; their quantities are measured after cooking: Eggs, hard-boiled. Cook them separately using their packet directions, or use a suitable ready-cooked product."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turmeric Ginger Oatmeal with Berries and Walnuts",
    "newName": "Turmeric Ginger Oatmeal with Berries and Walnuts",
    "expectedIngredients": [
      {
        "name": "Fresh ginger, grated",
        "amount": "1 tsp"
      },
      {
        "name": "Mixed berries",
        "amount": "1/2 cup"
      },
      {
        "name": "Rolled oats",
        "amount": "1/2 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      },
      {
        "name": "Walnuts",
        "amount": "2 tbsp"
      },
      {
        "name": "Water or plant milk",
        "amount": "1 cup"
      }
    ],
    "expectedInstructions": [
      "Simmer oats in water or plant milk over medium heat, stirring occasionally, for 5-7 minutes.",
      "Stir in turmeric and grated ginger during the last minute of cooking.",
      "Transfer to a bowl and top with berries and walnuts."
    ],
    "instructions": [
      "Simmer oats in water or plant milk over medium heat, stirring occasionally, for 5-7 minutes.",
      "Stir in turmeric and grated ginger during the last minute of cooking.",
      "Transfer to a bowl and top with berries and walnuts."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.quakeroats.com/products/hot-cereals/old-fashioned-oats"
      ]
    }
  },
  {
    "name": "Turmeric Roasted Chickpeas",
    "newName": "Turmeric Roasted Chickpeas",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Chickpeas, drained",
        "amount": "1 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Smoked paprika",
        "amount": "1/4 tsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Pat chickpeas dry and toss with olive oil, turmeric, black pepper, and smoked paprika.",
      "Spread on a baking sheet and roast for 25-30 minutes, stirring occasionally, until crisp."
    ],
    "instructions": [
      "Preheat oven to 200C/400F.",
      "Pat chickpeas dry and toss with olive oil, turmeric, black pepper, and smoked paprika.",
      "Spread on a baking sheet and roast for 25-30 minutes, stirring occasionally, until crisp."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turmeric Roasted Chickpeas with Parmesan (Non-Vegan Alt)",
    "newName": "Turmeric Roasted Chickpeas with Parmesan (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Chickpeas, drained",
        "amount": "1 cup"
      },
      {
        "name": "Olive oil",
        "amount": "1 tbsp"
      },
      {
        "name": "Parmesan, grated",
        "amount": "2 tbsp"
      },
      {
        "name": "Smoked paprika",
        "amount": "1/4 tsp"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Preheat oven to 200C/400F.",
      "Pat chickpeas dry and toss with olive oil, turmeric, black pepper, and smoked paprika.",
      "Spread on a baking sheet and roast for 25-30 minutes, stirring occasionally, until crisp.",
      "Toss with grated parmesan while still warm."
    ],
    "instructions": [
      "Preheat oven to 200C/400F.",
      "Pat chickpeas dry and toss with olive oil, turmeric, black pepper, and smoked paprika.",
      "Spread on a baking sheet and roast for 25-30 minutes, stirring occasionally, until crisp.",
      "Toss with grated parmesan while still warm."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Use canned, drained and rinsed beans/chickpeas, or ones fully cooked separately. These short methods do not cook dried beans."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Turmeric Scrambled Eggs with Spinach and Roasted Tomatoes",
    "newName": "Turmeric Scrambled Eggs with Spinach and Roasted Tomatoes",
    "expectedIngredients": [
      {
        "name": "Black pepper",
        "amount": "pinch"
      },
      {
        "name": "Cherry tomatoes",
        "amount": "6"
      },
      {
        "name": "Eggs",
        "amount": "2"
      },
      {
        "name": "Microgreens",
        "amount": "small handful"
      },
      {
        "name": "Olive oil",
        "amount": "1 tsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tsp"
      },
      {
        "name": "Spinach",
        "amount": "1 cup"
      },
      {
        "name": "Turmeric",
        "amount": "1/2 tsp"
      }
    ],
    "expectedInstructions": [
      "Roast cherry tomatoes with a little olive oil at 200C/400F for 10 minutes.",
      "Whisk eggs with turmeric and black pepper.",
      "Heat olive oil in a pan and wilt spinach for 1 minute.",
      "Pour in the egg mixture and scramble gently until just set.",
      "Plate with roasted tomatoes, then finish with microgreens and pomegranate seeds."
    ],
    "instructions": [
      "Preheat a conventional oven to 200°C. Toss the tomatoes with a little of the listed olive oil and roast for about 10-15 minutes until softened.",
      "Beat the eggs with the turmeric and black pepper; wash and dry the spinach.",
      "Heat the remaining oil in a non-stick frying pan over low-medium heat and stir the spinach for about 1 minute until wilted.",
      "Add the eggs and stir gently for about 2-4 minutes until set with no liquid egg; use the egg-dish cooking check below.",
      "Serve with the roasted tomatoes, microgreens and pomegranate seeds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [
        "egg-dish",
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts",
        "https://www.foodsafety.gov/food-safety-charts/safe-minimum-internal-temperatures"
      ]
    }
  },
  {
    "name": "Walnut and Date Energy Balls",
    "newName": "Walnut and Date Energy Balls",
    "expectedIngredients": [
      {
        "name": "Cacao powder",
        "amount": "1 tbsp"
      },
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Dates, pitted",
        "amount": "1 cup"
      },
      {
        "name": "Walnuts",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Blend pitted dates and walnuts in a food processor until a sticky dough forms.",
      "Add cinnamon and cacao powder, and blend to combine.",
      "Roll the mixture into small balls, about 12.",
      "Refrigerate for at least 30 minutes before serving; makes about 12 balls."
    ],
    "instructions": [
      "Blend pitted dates and walnuts in a food processor until a sticky dough forms.",
      "Add cinnamon and cacao powder, and blend to combine.",
      "Roll the mixture into small balls, about 12.",
      "Refrigerate for at least 30 minutes before serving; makes about 12 balls."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Walnut, Date, and Honey Energy Balls (Non-Vegan Alt)",
    "newName": "Walnut, Date, and Honey Energy Balls (Non-Vegan Alt)",
    "expectedIngredients": [
      {
        "name": "Cacao powder",
        "amount": "1 tbsp"
      },
      {
        "name": "Cinnamon",
        "amount": "1/2 tsp"
      },
      {
        "name": "Dates, pitted",
        "amount": "1 cup"
      },
      {
        "name": "Honey",
        "amount": "1 tsp"
      },
      {
        "name": "Walnuts",
        "amount": "1/2 cup"
      }
    ],
    "expectedInstructions": [
      "Blend pitted dates and walnuts in a food processor until a sticky dough forms.",
      "Add cinnamon, cacao powder, and honey, and blend to combine.",
      "Roll the mixture into small balls, about 12.",
      "Refrigerate for at least 30 minutes before serving; makes about 12 balls."
    ],
    "instructions": [
      "Blend pitted dates and walnuts in a food processor until a sticky dough forms.",
      "Add cinnamon, cacao powder, and honey, and blend to combine.",
      "Roll the mixture into small balls, about 12.",
      "Refrigerate for at least 30 minutes before serving; makes about 12 balls."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [],
      "cookingChecks": [],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  },
  {
    "name": "Whipped Coconut Cream with Cinnamon and Pomegranate (Yogurt-Free)",
    "newName": "Whipped Coconut Cream with Cinnamon and Pomegranate (Yogurt-Free)",
    "expectedIngredients": [
      {
        "name": "Cinnamon",
        "amount": "1/4 tsp"
      },
      {
        "name": "Full-fat coconut milk, chilled overnight",
        "amount": "1 can"
      },
      {
        "name": "Honey or maple syrup",
        "amount": "1 tsp"
      },
      {
        "name": "Pomegranate seeds",
        "amount": "1 tbsp"
      }
    ],
    "expectedInstructions": [
      "Scoop out only the solid cream from the top of the chilled coconut milk can.",
      "Whip briefly with a fork or whisk until light.",
      "Top with honey or maple syrup, cinnamon, and pomegranate seeds."
    ],
    "instructions": [
      "Scoop out only the solid cream from the top of the chilled coconut milk can.",
      "Whip briefly with a fork or whisk until light.",
      "Top with honey or maple syrup, cinnamon, and pomegranate seeds."
    ],
    "recipeContent": {
      "version": "2026-10-10.v1",
      "reviewStatus": "editorial",
      "kitchenTested": false,
      "methodBasis": "existing-recipe-with-editorial-clarification",
      "timingNote": "Cooking times are approximate guides, not guarantees; check the stated doneness. Ingredient size, equipment and batch size can change the time. Oven temperatures here refer to conventional ovens; follow your oven guidance for fan settings.",
      "ingredientNotes": [
        "Chill the unopened coconut milk can in the fridge overnight first so the cream separates. This waiting time is additional to the hands-on preparation time."
      ],
      "cookingChecks": [
        "storage"
      ],
      "sourceUrls": [
        "https://www.gov.uk/government/publications/cooking-your-food/cooking-your-food",
        "https://www.fda.gov/food/buy-store-serve-safe-food/selecting-and-serving-produce-safely",
        "https://www.foodsafety.gov/food-safety-charts/cold-food-storage-charts"
      ]
    }
  }
]$recipe_payload$::jsonb)
    LOOP
        IF (SELECT count(*) FROM meals WHERE name = recipe->>'name') <> 1 THEN
            RAISE NOTICE 'Recipe revision skipped missing or ambiguous name: %', recipe->>'name';
            CONTINUE;
        END IF;
        SELECT id INTO target_id FROM meals WHERE name = recipe->>'name' FOR UPDATE;
        SELECT coalesce(jsonb_agg(instruction ORDER BY step_order), '[]'::jsonb)
          INTO original_steps FROM meal_instructions WHERE meal_id = target_id;
        SELECT coalesce(jsonb_agg(jsonb_build_object('name', name, 'amount', amount) ORDER BY name COLLATE "C", coalesce(amount, '') COLLATE "C"), '[]'::jsonb)
          INTO original_ingredients FROM meal_ingredients WHERE meal_id = target_id;
        IF original_steps IS DISTINCT FROM recipe->'expectedInstructions'
           OR original_ingredients IS DISTINCT FROM recipe->'expectedIngredients' THEN
            RAISE NOTICE 'Recipe revision preserved custom recipe: %', recipe->>'name';
            CONTINUE;
        END IF;
        DELETE FROM meal_instructions WHERE meal_id = target_id;
        INSERT INTO meal_instructions (meal_id, step_order, instruction)
        SELECT target_id, step.ordinality - 1, step.value
          FROM jsonb_array_elements_text(recipe->'instructions') WITH ORDINALITY AS step(value, ordinality);
        UPDATE meals SET name = recipe->>'newName', recipe_content = recipe->'recipeContent' WHERE id = target_id;
        changed_count := changed_count + 1;
    END LOOP;
    RAISE NOTICE 'Recipe content reviewed for % seeded recipes', changed_count;
END;
$recipe_revision$;
