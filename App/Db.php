<?php


namespace App;

class Db
{

    use Singleton;

    const DB_NAME = 'psychoan_zavod';

    protected $dbh;

    protected function __construct()
    {
        try {
            $this->dbh = new \PDO(
                'mysql:host=localhost;dbname=' . self::DB_NAME,
                'root',
                '',
                array(
                    \PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''
                )
            );
        } catch (\PDOException $e) {
            throw new \App\Exceptions\Db($e->getMessage());
        }
    }

    public function execute(string $sql, array $params = [])
    {
        $sth = $this->dbh->prepare($sql);
        $res = $sth->execute($params);
        return $res;
    }

    public function query(string $sql, array $data = [], string $class = \stdClass::class)
    {

        $sth = $this->dbh->prepare($sql);
        $res = $sth->execute($data);
        if (false !== $res) {
            return $sth->fetchAll(\PDO::FETCH_CLASS, $class);
        }
        return [];
    }

}