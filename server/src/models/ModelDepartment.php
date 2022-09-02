<?php
	require_once '../src/models/BaseModel.php';

	class ModelDepartment extends BaseModel{
		public static function getFields(){
			return array(
				"deptname"
			);
		}
	}
