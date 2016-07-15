module Mortgage where

allValues startValue apr payment
  | startValue <= 0 = [0]
  | otherwise = startValue : (allValues next apr payment)
    where
      next = startValue * (1 + apr) - payment

