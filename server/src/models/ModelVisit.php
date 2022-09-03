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
			if (isset($obj->dept_id)) $obj->department = ModelDepartment::retrieve($obj->dept_id);

			$str = "SELECT imgpath1 FROM visitimage where visit_id = " . $id  . " and imgpath1 is not null order by imgpath1 desc";
	    $rows =  DB::openQuery($str);
			if (isset($rows[0])) {
				$obj->imgpath1 = $rows[0]->imgpath1;
			}

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

				if (( isset($obj->visitor_id)) && (isset($obj->visitor)) ){
					$sql = 'update visitor set lastvisit_id = '. $db->quote($obj->id)
							. ' , visitorname = '. $db->quote($obj->visitor->visitorname)
							. ' , address = '. $db->quote($obj->visitor->address)
							. ' , idcardno = '. $db->quote($obj->visitor->idcardno)
							. ' , company = '. $db->quote($obj->visitor->company)
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
