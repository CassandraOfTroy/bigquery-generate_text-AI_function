--Generate the positive/negative sentiment
SELECT
  ml_generate_text_result['predictions'][0]['content'] AS review_sentiment,
  * EXCEPT (ml_generate_text_status,ml_generate_text_result)
FROM
  ML.GENERATE_TEXT(
    MODEL `hair_shop.llm_model`,
    (
      SELECT
        CONCAT('Extract the one word sentiment from product_review column. Possible values are positive/negative/neutral ', product_review) AS prompt,
        *
      FROM
        `macro-dreamer-393017.hair_shop.product_review_table`
      LIMIT 5
    ),
    STRUCT(
      0.1 AS temperature,
      2 AS max_output_tokens,
      0.1 AS top_p, 
      1 AS top_k));
