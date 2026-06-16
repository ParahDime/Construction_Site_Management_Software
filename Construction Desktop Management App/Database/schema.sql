-- Table of user information, most other tables will call back to this one
CREATE TABLE IF NOT EXISTS users (
	id UUID PRIMARY KEY,
	username STRING NOT NULL,
	email STRING, 
	role STRING, 
	is_subcontractor BOOL DEFAULT FALSE,
	created_by UUID
)

CREATE TABLE IF NOT EXISTS plots (
	id UUID PRIMARY KEY,
    plot_number STRING NOT NULL,
	description STRING,
	status STRING,
	start_date DATE,
	target_completion DATE
)

CREATE TABLE IF NOT EXISTS plant_equipment (
	id UUID PRIMARY KEY,
	name STRING,
	type STRING,
	plate_or_serial STRING NOT NULL,
	owner STRING,
	last_tested DATE,
	is_leased BOOL,
	lease_start DATE,
	lease_end DATE,
	lease_cost DECIMAL
)

CREATE TABLE IF NOT EXISTS user_compliance (
	id UUID PRIMARY KEY,
	user_id UUID FOREIGN KEY NOT NULL REFERENCES users(id),
	cscs_card_number STRING,
	trade STRING,
	cscs_expiry DATE,
	license_type STRING,
	license_expiry DATE,
	insurance_expiry DATE,
	scanned_doc_url STRING
)

CREATE TABLE IF NOT EXISTS site_attendance (
	id UUID PRIMARY KEY,
	user_id UUID FOREIGN KEY NOT NULL REFERENCES users(id),
	work_date DATE,
	sign_in_time TIMESTAMP,
	sign_out_time TIMESTAMP,
	manager_approved BOOL,
	is_manual_entry BOOL
)

CREATE TABLE IF NOT EXISTS plot_documents (
	id UUID PRIMARY KEY,
	plot_id UUID REFERENCES plots(id),
	file_url STRING,
	file_type STRING,
	version INT,
	uploaded_by UUID REFERENCES users(id),
	uploaded_at TIMESTAMP
)

CREATE TABLE IF NOT EXISTS snags (
	id UUID PRIMARY KEY,
	plot_id UUID REFERENCES plots(id),
	raised_by UUID REFERENCES users(id),
	description STRING,
	status STRING,
	confirmed_by UUID REFERENCES users(id),
	raised_at TIMESTAMP,
	confirmed_at TIMESTAMP
)

CREATE TABLE IF NOT EXISTS sync_queue (
	id UUID PRIMARY KEY,
	user_id UUID NOT NULL REFERENCES users(id),
	action_type STRING,
	payload JSON,
	synced BOOL,
	queued_at TIMESTAMP,
	synced_at TIMESTAMP
)

CREATE TABLE IF NOT EXISTS audit_log (
	id UUID PRIMARY KEY,
	user_id UUID NOT NULL REFERENCES users(id),
	action STRING,
	table_name STRING,
	record_id UUID,
	actioned_at TIMESTAMP
)

--Dependant of snags, stores details of snag photos for evidence
CREATE TABLE IF NOT EXISTS snag_photos (
	id UUID PRIMARY KEY,
	snag_id UUID REFERENCES snags(id),
	photo_url STRING,
	taken_at TIMESTAMP
)

