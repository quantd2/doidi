class AddTriggerConstraintRelationships < ActiveRecord::Migration[5.0]
  def up
    execute %{
      CREATE OR REPLACE FUNCTION
        enforce_relationship_count()
        RETURNS TRIGGER LANGUAGE PLPGSQL
      AS $$

      DECLARE
        max_relationships_count INTEGER := 3;
        following_count INTEGER := 0;
        followed_count INTEGER := 0;

      BEGIN

        LOCK TABLE relationships IN EXCLUSIVE MODE;

        SELECT INTO following_count COUNT(*)
        FROM relationships
        WHERE follower_id = NEW.follower_id;
        RAISE NOTICE 'following_count is currently %', following_count;

        SELECT INTO followed_count COUNT(*)
        FROM relationships
        WHERE followed_id = NEW.followed_id;
        RAISE NOTICE 'followed_count is currently %', followed_count;

        IF following_count > max_relationships_count THEN
          RAISE EXCEPTION 'Cannot insert more than % following for each item.', max_relationships_count;
        END IF;

        IF followed_count > max_relationships_count THEN
          RAISE EXCEPTION 'Cannot insert more than % followed for each item.', max_relationships_count;
        END IF;

        RETURN NEW;
      END $$;
    }

    execute %{
      CREATE TRIGGER enforce_relationship_count_trg
      BEFORE
        INSERT OR UPDATE
        ON relationships
      FOR EACH ROW
        EXECUTE PROCEDURE enforce_relationship_count()
    }
  end

  def down
    execute %{
      DROP TRIGGER enforce_relationship_count_trg ON relationships;
      DROP FUNCTION enforce_relationship_count();
    }
  end
end
