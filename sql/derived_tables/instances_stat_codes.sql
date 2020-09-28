DROP TABLE IF EXISTS local.instances_stat_codes;

CREATE TABLE local.instances_stat_codes AS
WITH instances_statistical_codes AS (
    SELECT
        instance.id AS instance_id,
        instance.hrid AS instance_hrid,
        json_array_elements_text(json_extract_path(instance.data, 'statisticalCodeIds')) AS instance_statistical_code_id
    FROM
        inventory_instances AS instance
)
SELECT
    instances_statistical_codes.instance_id,
    instances_statistical_codes.instance_hrid,
    instances_statistical_codes.instance_statistical_code_id,
    inventory_statistical_codes.code AS statistical_code,
    inventory_statistical_codes.name AS statistical_code_name,
    inventory_statistical_code_types.id AS statistical_code_type_id,
    inventory_statistical_code_types.name AS statistical_code_type_name
FROM
    instances_statistical_codes
    LEFT JOIN inventory_statistical_codes ON instances_statistical_codes.instance_statistical_code_id = inventory_statistical_codes.id
    LEFT JOIN inventory_statistical_code_types ON inventory_statistical_codes.statistical_code_type_id = inventory_statistical_code_types.id;

CREATE INDEX ON local.instances_stat_codes (instance_id);

CREATE INDEX ON local.instances_stat_codes (instance_hrid);

CREATE INDEX ON local.instances_stat_codes (instance_statistical_code_id);

CREATE INDEX ON local.instances_stat_codes (statistical_code);

CREATE INDEX ON local.instances_stat_codes (statistical_code_name);

CREATE INDEX ON local.instances_stat_codes (statistical_code_type_id);

CREATE INDEX ON local.instances_stat_codes (statistical_code_type_name);

VACUUM local.instances_stat_codes;

ANALYZE local.instances_stat_codes;
