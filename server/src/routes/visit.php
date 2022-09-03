<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\UploadedFileInterface;

require '../vendor/autoload.php';
require_once '../src/classes/DB.php';
require_once '../src/models/ModelVisit.php';

$app->get('/visit_delete/{id}', function ($request, $response) {  //if hosting not allowed del
  try{
    $data = ModelVisit::deleteFromDB($request->getAttribute('id'));
		return $response->withHeader('Content-Type', 'application/json;charset=utf-8');
	}catch(Exception $e){
    $msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}
});

$app->get('/visit', function ($request, $response) {
  try{
    $data = ModelVisit::retrieveList();
    $json = json_encode($data);
    $response->getBody()->write($json);

		return $response->withHeader('Content-Type', 'application/json;charset=utf-8');
	}catch(Exception $e){
    $msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}
});

$app->get('/visit/{id}', function ($request, $response, $args) {
	try{
    $id = $request->getAttribute('id');
    $data = ModelVisit::retrieve($id);
    $json = json_encode($data);
    $response->getBody()->write($json);
		return $response->withHeader('Content-Type', 'application/json;charset=utf-8');
	}catch(Exception $e){
    $msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}
});


$app->get('/visitimage/{id}', function ($request, $response, $args) {
	try{
    $id = $request->getAttribute('id');
    $str = "SELECT encode(img1, 'base64')  as img1 FROM visitimage where visit_id = " . $id ;
    $obj =  DB::openQuery($str);
    $img = $obj[0]->img1;


    echo '<img crossorigin=""  src="data:image/jpeg;base64,'.$img.'"/>';

    return $response->withHeader("Content-Type", "image/jpeg");
		// return $response->withHeader('Content-Type', 'image/jpeg');
    // return $response->withHeader('Content-Type', 'text/html');
	}catch(Exception $e){
    $msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}
});



$app->get('/visitimageurl/{id}', function ($request, $response, $args) {
	try{
    $id = $request->getAttribute('id');
    $str = "SELECT imgpath1 FROM visitimage where visit_id = " . $id  . " and imgpath1 is not null order by imgpath1 desc";
    $obj =  DB::openQuery($str);

    // if($obj[0] == null) $response->withHeader("Content-Type", "text/html");

    $url = $obj[0]->imgpath1;

    //PR bikinkan config
    // $config = parse_ini_file("../src/config.ini");
  	// $directory =  $config["upload_directory"];
    // $directory = $directory . DIRECTORY_SEPARATOR; //. $year;

    $response->getBody()->write($url);

    return $response->withHeader("Content-Type", "text/html");
		// return $response->withHeader('Content-Type', 'image/jpeg');
    // return $response->withHeader('Content-Type', 'text/html');
	}catch(Exception $e){
    $msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}
});




$app->post('/visit', function ($request, $response) {
  $json = $request->getParam('data');
	$obj = json_decode($json);

  // var_dump($obj);
	try{
		ModelVisit::saveToDB($obj);
    $json = json_encode($obj);
    executeUploadFile($request, $obj->id);

    $response->getBody()->write($json);

    return $response->withHeader('Content-Type', 'application/json;charset=utf-8');
	}catch(Exception $e){
		$msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}

});


function moveUploadedFile($directory, UploadedFileInterface $uploadedFile)
{
	$filename = $uploadedFile->getClientFilename();
	$uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);
	return $filename;
}


function uploadFromData($data, $id) {

    //PR overwrite filename
    $ext = null;

    if(strpos($data, 'data:image/jpeg;base64,') === 0) {
        $data = str_replace('data:image/jpeg;base64,', '', $data);
        $ext = '.jpg';
    } elseif (strpos($data, 'data:image/jpg;base64,') === 0) {
        $data = str_replace('data:image/jpg;base64,', '', $data);
        $ext = '.jpg';
    } elseif (strpos($data, 'data:image/png;base64,') === 0) {
        $data = str_replace('data:image/png;base64,', '', $data);
        $ext = '.png';
    } elseif (strpos($data, 'data:image/gif;base64,') === 0) {
        $data = str_replace('data:image/gif;base64,', '', $data);
        $ext = '.gif';
    }

    //debugging purpose
    $config = parse_ini_file("../src/config.ini");
  	$directory =  $config["upload_directory"];

  	// $year = date("Y");;

  	$directory = $directory . DIRECTORY_SEPARATOR; //. $year;

  	if (!file_exists($directory)) {
  		mkdir($directory, 0777, true);
  	}

    if($ext != null) {
        $image = base64_decode($data);

        $filename = date('YmdHis') . '.' . createToken() . $ext;

        if(file_put_contents($directory . DIRECTORY_SEPARATOR . $filename, $image) !== FALSE) {
          $db = new DB();
          $db = $db->connect();
          $db->beginTransaction();
          try {
            // $sql = "INSERT INTO visitimage (visit_id, img1) VALUES(:visit_id, decode(:img1,'base64') )";
            $sql = "INSERT INTO visitimage (visit_id, imgpath1) VALUES(:visit_id, :imgpath1 )";


            $stmt = $db->prepare($sql);


            $stmt->execute([
                ':visit_id' => $id,
                ':imgpath1' => $filename
            ]);

            $db->commit();
          } catch (Exception $e) {
            $db->rollback();
            throw $e;
          }

          return $filename;
        }
    }

    return null;
}

function createToken() {
    return bin2hex(openssl_random_pseudo_bytes(16));
}

function executeUploadFile($request, $id){
	// // $config = parse_ini_file("../src/config.ini");
	// // $directory =  $config["upload_directory"];
  //
	// $year = date("Y");;
  //
	// // $directory = $directory . DIRECTORY_SEPARATOR . $year;
  // //
	// // if (!file_exists($directory)) {
	// // 	mkdir($directory, 0777, true);
	// // }

  $uploadedFile = $request->getParam('img1');
  uploadFromData($uploadedFile, $id );

}
