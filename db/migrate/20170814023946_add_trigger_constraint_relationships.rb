class AddTriggerConstraintRelationships < ActiveRecord::Migration[5.0]
  def up
    execute %{
      CREATE OR REPLACE FUNCTION
        enforce_relationship_count()
        RETURNS TRIGGER LANGUAGE PLPGSQL
      AS $$

      DECLARE
        max_relationships_count INTEGER := 1;
        demanding_count INTEGER := 0;
        granter_count INTEGER := 0;

      BEGIN

        LOCK TABLE relationships IN EXCLUSIVE MODE;

        SELECT INTO demanding_count COUNT(*)
        FROM relationships
        WHERE demander_id = NEW.demander_id;
        RAISE NOTICE 'demanding_count is currently %', demanding_count;

        SELECT INTO granter_count COUNT(*)
        FROM relationships
        WHERE granter_id = NEW.granter_id;
        RAISE NOTICE 'granter_count is currently %', granter_count;

        IF demanding_count > max_relationships_count THEN
          RAISE EXCEPTION 'Cannot insert more than % demanding for each item.', max_relationships_count;
        END IF;

        IF granter_count > max_relationships_count THEN
          RAISE EXCEPTION 'Cannot insert more than % granter for each item.', max_relationships_count;
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
