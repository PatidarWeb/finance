<?php

declare(strict_types=1);

if (! function_exists('assetPath')) {
    function assetPath($path, $type)
    {
        if ($type === 'theme') {
            return asset(
                sprintf("%s/%s", 'theme', $path)
            );
        } elseif ($type === 'custom') {
            return asset(
                sprintf("%s/%s", asset('assets'), $path)
            );
        } else {
            return $path;
        }
    }
}
