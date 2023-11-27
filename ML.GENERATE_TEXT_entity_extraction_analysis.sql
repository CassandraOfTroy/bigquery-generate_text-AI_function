--Check what's the reason behind the positive/negative sentiment
SELECT
  ml_generate_text_result['predictions'][0]['content'] AS generated_text,
  * EXCEPT (ml_generate_text_status,ml_generate_text_result)
FROM
  ML.GENERATE_TEXT(
    MODEL `hair_shop.llm_model`,
    (
      SELECT
        CONCAT('What is the reason for a review of the product? Possible options are: good/bad/average product quality, delivery delay, low/high price', product_review) AS prompt,
        *
      FROM
        `macro-dreamer-393017.hair_shop.product_review_table`
      LIMIT 5
    ),
    STRUCT(
      0.2 AS temperature,
      100 AS max_output_tokens,
      0.2 AS top_p, 
      15 AS top_k));
