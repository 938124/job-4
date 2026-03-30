INSERT INTO development_011_bronze_core.db_admin.pipeline
  (pipeline_name, pipeline_description, pipeline_enabled, created_date, modified_date)
VALUES ('Atlas_Bronze_Install_Base', 'Atlas_Bronze_Install_Base', true, current_date(), current_date());

INSERT INTO development_011_bronze_core.db_admin.pipeline_parameter (
  pipeline_id, variable_name, variable_value, created_date, modified_date
)
SELECT p.pipeline_id, pp.variable_name, pp.variable_value, current_date(), current_date()
FROM development_011_bronze_core.db_admin.pipeline p
CROSS JOIN (
  VALUES
    ('db_catalog',     'development_021_bronze_finance.atlas'),
    ('archive_folder', 's3://cluster-private-bucket-481980074735-us-east-1/intake/atlas/archive/excel/'),
    ('failure_folder', 's3://cluster-private-bucket-481980074735-us-east-1/intake/atlas/failure/excel/'),
    ('workbook_path',  's3://cluster-private-bucket-481980074735-us-east-1/intake/atlas/manual/install_base/Install Base Upload 2-21.xlsx'),
    ('sheet_mapping',  '[
  {
    "sheet_name": "PSD",
    "header_rows_to_skip": 3,
    "footer_rows_to_skip": 0,
    "has_header_row": true,
    "destination_table": "development_021_bronze_finance.atlas.GameOpsInstallBasePSD"
  },
  {
    "sheet_name": "Activity by Serial",
    "header_rows_to_skip": 3,
    "footer_rows_to_skip": 0,
    "has_header_row": true,
    "destination_table": "development_021_bronze_finance.atlas.GameOpsInstallBaseActivity"
  }
]')
) AS pp(variable_name, variable_value)
WHERE p.pipeline_name = 'Atlas_Bronze_Install_Base';
