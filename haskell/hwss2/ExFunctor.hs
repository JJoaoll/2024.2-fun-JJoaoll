module ExFunctor where

import Prelude hiding ( fmap , (<$) )

class Funktor f where
  fmap :: (a -> b) -> f a -> f b

  (<$) :: b        -> f a -> f b
  (<$) = fmap . const


instance Funktor [] where
    fmap :: (a -> b) -> [a] -> [b] 
    fmap = map

instance Funktor Maybe where
    fmap :: (a -> b) -> Maybe a -> Maybe b 
    fmap _ Nothing  = Nothing 
    fmap f (Just x) = Just (f x)

-- what about Either?
instance Funktor (Either e) where
  fmap :: (a -> b) -> Either e a -> Either e b 
  fmap _ (Left e)  = Left e
  fmap f (Right x) = Right (f x)

-- instance Funktor (Either _ v) where 
-- Osu (How)


data Pair a b = Pair a b

-- what about pairs?
instance Funktor (Pair a) where
  fmap :: (b -> c) -> (Pair a b -> Pair a c)
  fmap f (Pair x y) = Pair x (f y) 

-- what about functions?
instance Funktor ((->) a) where
  --comp... 
  fmap :: (b -> c) -> ((a -> b) -> (a -> c))
  fmap = (.)


data BinTree a b where 
  Node :: a -> BinTree a b
  Fork :: b -> BinTree a b -> BinTree a b -> BinTree a b


-- what about Trees?
instance Funktor (BinTree a) where 
  fmap :: (b -> c) -> (BinTree a b -> BinTree a c)
  fmap _ (Node x)     = Node x 
  fmap f (Fork y l r) = Fork (f y) (fmap f l) (fmap f r)


-- what about IO? 


-- ...define Functor instances of as many * -> * things as you can think of!

