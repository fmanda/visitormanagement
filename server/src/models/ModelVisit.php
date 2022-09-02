<?php
	require_once '../src/models/BaseModel.php';
	require_once '../src/models/ModelVisitor.php';

	class ModelVisit extends BaseModel{
		public static function getFields(){
			return array(
				"visitor_id", "entrydate", "exitdate", "dept_id", "person_to_meet", "reason", "img_path", "user_id"
			);
		}

		public static function retrieve($id){
			$obj = parent::retrieve($id);
			if (isset($obj->visitor_id)) $obj->visitor = ModelVisitor::retrieve($obj->visitor_id);
			return $obj;
		}

		public static function retrieveList($filter=''){
			$sql = 'select a.*, b.*, c.deptname from visit a
							left join visitor b on a.visitor_id = b.id
							left join department c on a.dept_id = c.id
							';
			if ($filter<>''){
				$sql = $sql .' and '. $filter;
			}
			$obj = DB::openQuery($sql);
			return $obj;
		}

		private static function isNewVisitor($obj){
			$isNew = true;
			if (isset($obj->visitor_id)) {
				if($obj->visitor_id > 0) {
					$isNew = false;
				}
			}
			return $isNew;
		}

		public static function saveToDB($obj){
			$db = new DB();
			$db = $db->connect();
			$db->beginTransaction();
			try {

				if (ModelVisit::isNewVisitor($obj)){
					if (!isset($obj->visitor)) throw new Exception('Visitor Object empty');
					ModelVisitor::saveToDB($obj->visitor);
					$obj->visitor_id = $obj->visitor->id;
				}
				static::saveObjToDB($obj, $db);

				if (isset($obj->visitor_id)) {
					$sql = 'update visitor set lastvisit_id = '. $db->quote($obj->id)
							. ' where id = '. $db->quote($obj->visitor_id);
					$db->prepare($sql)->execute();
				}

				$db->commit();
				$db = null;

			} catch (Exception $e) {
				$db->rollback();
				throw $e;
			}
		}


	}
