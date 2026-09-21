<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class JSONRequestController extends Controller 
{	
	const URL = 'https://my-json-server.typicode.com/brianlivramento/json_system_activities/';
	
	public function getCategoriesAllAction()
	{
		$json = file_get_contents(self::URL . 'categories');
		return json_decode($json);
	}

	public function getActivitiesAllAction()
	{
		$json = file_get_contents(self::URL . 'activities');
		return json_decode($json);
	}

	public function getCommentsAllAction()
	{
		$json = file_get_contents(self::URL . 'comments');
		return json_decode($json);
	}	
}