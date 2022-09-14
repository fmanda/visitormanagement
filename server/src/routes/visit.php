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

$app->get('/ongoingvisit', function ($request, $response) {
  try{
    $data = ModelVisit::retrieveList('exitdate is null');
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
    $str = "SELECT imgpath1, imgpath2 FROM visitimage where visit_id = " . $id . "  order by imgpath1 desc";
    $obj =  DB::openQuery($str);

    // if($obj[0] == null) $response->withHeader("Content-Type", "text/html");

    $json = json_encode($obj[0]);

    //PR bikinkan config
    // $config = parse_ini_file("../src/config.ini");
  	// $directory =  $config["upload_directory"];
    // $directory = $directory . DIRECTORY_SEPARATOR; //. $year;

    $response->getBody()->write($json);

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


$app->get('/endvisit/{id}', function ($request, $response, $args) {
	try{
    $id = $request->getAttribute('id');
    $date = ModelVisit::endvisit($id);
    $response->getBody()->write($date);

    return $response->withHeader("Content-Type", "text/html");
	}catch(Exception $e){
    $msg = $e->getMessage();
    $response->getBody()->write($msg);
		return $response->withStatus(500)
			->withHeader('Content-Type', 'text/html');
	}
});




$app->post('/visit', function ($request, $response) {
  $json = $request->getParsedBody()['data'];
  var_dump($json);
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

function executeUploadFile($request, $id){
  // $uploadedFile = $request->getParsedBodyParam('img1');
  $uploadedFile = $request->getParsedBody()['img1'];
  uploadFromData($uploadedFile, $id, (int) 1 );

  $uploadedFile = $request->getParsedBody()['img2'];
  uploadFromData($uploadedFile, $id,  (int) 2 );
}


function moveUploadedFile($directory, UploadedFileInterface $uploadedFile)
{
	$filename = $uploadedFile->getClientFilename();
	$uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);
	return $filename;
}


function uploadFromData($data, $id,  $imgidx) {
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

    $config = parse_ini_file("../src/config.ini");
  	$directory =  $config["upload_directory"];

  	$directory = $directory . DIRECTORY_SEPARATOR; //. $year;

  	if (!file_exists($directory)) {
  		mkdir($directory, 0777, true);
  	}

    if($ext != null) {
        $image = base64_decode($data);
        // $filename = date('YmdHis') . '.' . createToken() . $ext;
        $filename = date('YmdHis') . '_' .$id .'_'.  $imgidx  . $ext;
        if(file_put_contents($directory . DIRECTORY_SEPARATOR . $filename, $image) !== FALSE) {
          $db = new DB();
          $db = $db->connect();
          $db->beginTransaction();
          try {
            //$sql = 'INSERT INTO visitimage (visit_id, imgpath' . $imgidx . ') VALUES(:visit_id, :imgpath' . $imgidx . ' )';

            $sql = 'update visitimage set  imgpath' . $imgidx . ' = :imgpath' . ' where visit_id = :visit_id';

            $stmt = $db->prepare($sql);
            $stmt->execute([
                ':visit_id' => $id,
                ':imgpath'  => $filename
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
