<?php

namespace App;

abstract class Model
{

    const TABLE = '';
    const TEMPLATE = 'abstractTable';

    public $id;

    public static function findAll()
    {
        $db = Db::instance();
        return $db->query(
            'SELECT * FROM ' . static::TABLE,
            [],
            static::class
        );
    }

    public static function findById($id)
    {
        $db = Db::instance();
        return $db->query(
            'SELECT * FROM ' . static::TABLE . ' WHERE id=:id',
            [':id' => $id],
            static::class
        )[0];
    }

    public function isNew()
    {
        return empty($this->id);
    }

    public function insert()
    {

        if (!$this->isNew()) {
            return;
        }

        $columns = [];
        $values = [];
        foreach ($this as $k => $v) {
            if ('id' == $k) {
                continue;
            }
            $columns[] = $k;
            $values[':' . $k] = $v;
        }

        $sql = '
INSERT INTO ' . static::TABLE . '
(' . implode(',', $columns) . ')
VALUES
(' . implode(',', array_keys($values)) . ')
        ';

        $db = Db::instance();
        $db->execute($sql, $values);
    }

    public static function findByColumn($column, $value)
    {
        $db = Db::instance();
        $sql = 'SELECT * FROM ' . static::TABLE . ' WHERE ' . $column . '=:value';
        $res = $db->query($sql, [':value' => $value], static::class);
        if (empty($res)) {
            return false;
        } else {
            return $res;
        }
    }

    public static function findOneByColumn($column, $value)
    {
        $db = Db::instance();
        $sql = 'SELECT * FROM ' . static::TABLE . ' WHERE ' . $column . '=:value';
        $res = $db->query($sql, [':value' => $value], static::class)[0];
        if (empty($res)) {
            return false;
        } else {
            return $res;
        }
    }

    public static function findOneByColumns($arr)
    {
        $db = Db::instance();

        $sql = 'SELECT * FROM ' . static::TABLE . ' WHERE ';

        foreach ($arr as $item => $key) {
            $values[":" . $item] = $key;
            $sql .= $item . ' = :' . $item . ' AND ';
        }

        $sql = substr($sql, 0, -5);

        $res = $db->query($sql, $values, static::class)[0];

        if (empty($res)) {
            throw new \App\Exceptions\Db();
        } else {
            return $res;
        }
    }

    public static function findByColumns($arr)
    {
        $db = Db::instance();

        $sql = 'SELECT * FROM ' . static::TABLE . ' WHERE ';

        foreach ($arr as $item => $key) {
            $values[":" . $item] = $key;
            $sql .= $item . ' = :' . $item . ' AND ';
        }

        $sql = substr($sql, 0, -5);

        $res = $db->query($sql, $values, static::class);


        if (empty($res)) {
            throw new \App\Exceptions\Db();
        } else {
            return $res;
        }
    }

    protected function update()
    {
        $cols = [];
        $data = [];
        foreach ($this as $k => $v) {
            $data[':' . $k] = $v;
            if ('id' == $k) {
                continue;
            }
            $cols[] = $k . '=:' . $k;
        }
        $sql = '
        UPDATE ' . static::TABLE . '
        SET ' . implode(', ', $cols) . '
        WHERE id=:id 
        ';
        $db = Db::instance();
        $db->execute($sql, $data);
    }

    public function save()
    {

        if (!isset($this->id)) {

            $this->insert();
        } else {
            $this->update();
        }
    }

    public function delete()
    {
        $sql = 'DELETE FROM ' . static::TABLE . ' WHERE id = :id';
        $db = Db::instance();
        $db->execute($sql, array('id' => $this->id));
    }

    public function getColComments()
    {
        $sql = "SELECT column_name,column_comment FROM information_schema.columns WHERE table_schema='" . Db::DB_NAME . "' and table_name = '" . static::TABLE . "'";
        $db = Db::instance();
        return $res = $db->query($sql);
    }

    public function getTableComment()
    {
        $sql = "SELECT TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = '" . Db::DB_NAME . "' AND table_name = '" . static::TABLE . "'";
        $db = Db::instance();
        return $res = $db->query($sql)[0]->TABLE_COMMENT;
    }

    public static function getTables()
    {
        $sql = "SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" . Db::DB_NAME . "'";
        $db = Db::instance();
        return $res = $db->query($sql);
    }
}