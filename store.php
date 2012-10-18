<?php

function check($value)
{
    if (get_magic_quotes_gpc())
    {
        $value = stripslashes($value);
    }
    if (!is_numeric($value))
    {
        $value = "'" . mysql_real_escape_string($value) . "'";
    }
    return $value;
}

$api = "http://api.tumblr.com/v2/blog/miccrun.tumblr.com";
$api = "http://api.tumblr.com/v2/blog/targetstyle.tumblr.com";
$apikey = "eGyGS6rj0OHqG4QCwY9yXSjhiA4e3iBvGECpH74wbUhzXu2Nt9";

$db = mysql_connect("127.0.0.1","root","");
if (!$db)
{
    die('Could not connect: ' . mysql_error());
}
mysql_select_db("tumblr", $db);


//$file = file_get_contents("$api/info?api_key=$apikey");
$file = file_get_contents("$api/posts?api_key=$apikey&notes_info=true&reblog_info=true");
$data = json_decode($file,true);

if ($data['meta']['status'] == 200)
{
    $blog = $data['response']['blog'];

    $title = check($blog['title']);
    $posts = check($blog['posts']);
    $name = check($blog['name']);
    $url = check($blog['url']);
    $updated = check($blog['updated']);
    $description = check($blog['description']);
    $ask = check($blog['ask']);
    $ask_anon = check($blog['ask_anon']);
    $likes = check($blog['likes']);

    mysql_query("REPLACE INTO blogs SET title=$title,posts=$posts,name=$name,url=$url,
        updated=$updated,description=$description,ask=$ask,ask_anon=$ask_anon,likes=$likes");

    $text_count = 0;
    $photo_count = 0;

    foreach($data['response']['posts'] as $val)
    {
        $id = check($val['id']);
        $blog_name = check($val['blog_name']);
        $post_url = check($val['post_url']);
        $slug = check($val['slug']);
        $type = check($val['type']);
        $date = check($val['date']);
        $timestamp = check($val['timestamp']);
        $state = check($val['state']);
        $format = check($val['format']);
        $reblog_key = check($val['reblog_key']);
        $note_count = check($val['note_count']);
        $bookmarklet = check($val['bookmarklet']);
        $mobile = check($val['mobile']);
        $source_url = check($val['source_url']);
        $source_title = check($val['source_title']);

        $post_sql = $post_sql . "($id,$blog_name,$post_url,$slug,$type,$date,$timestamp,$state,$format,
            $reblog_key,$note_count,$bookmarklet,$mobile,$source_url,$source_title),";

        switch ($type)
        {
        case "'text'":
            $title = check($val['title']);
            $body = check($val['body']);
            $text_sql = $text_sql . "($id,$title,$body),";
            $text_count ++;
            break;
        case "'photo'":
            $caption = check($val['caption']);
            $photoset_layout = check($val['photoset_layout']);
            $photo_sql = $photo_sql . "($id,$caption,$photoset_layout),";
            $photo_count ++;
            break;
        }

    }

    $post_sql = substr_replace($post_sql,";",-1);
    $text_sql = substr_replace($text_sql,";",-1);
    $photo_sql = substr_replace($photo_sql,";",-1);

    echo $text_count;
    if ($data['response']['total_posts'] > 0) 
    mysql_query("REPLACE INTO posts (post_id,blog_name,post_url,slug,type,date,
        timestamp,state,format,reblog_key,note_count,bookmarklet,mobile,source_url,
        source_title) VALUES $post_sql");

    if ($text_count > 0)
    {
        mysql_query("REPLACE INTO texts (post_id,title,body) VALUES $text_sql");
        echo ("REPLACE INTO texts (post_id,titel,body) VALUES $text_sql");
    }

    if ($photo_count > 0)
    {
        mysql_query("REPLACE INTO photosets (post_id,caption,photoset_layout) VALUES $photo_sql");
    }
    //echo "OK";

}
else
{
    echo $data['meta']['msg'];
}


mysql_close($db);

?>
