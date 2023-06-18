<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'vrkansagara/finance') }}</title>


    <link href="{{assetPath('css/bootstrap.min.css','theme')}}" rel="stylesheet">
    <link href="{{assetPath('font-awesome/css/font-awesome.css','theme')}}" rel="stylesheet">

    <link href="{{assetPath('css/animate.css','theme')}}" rel="stylesheet">
    <link href="{{assetPath('css/style.css','theme')}}" rel="stylesheet">
</head>

<body class="@yield('body_class')">

@yield('content')

<!-- Mainly scripts -->
<script src="{{assetPath('js/jquery-3.1.1.min.js','theme')}}"></script>
<script src="{{assetPath('js/popper.min.js','theme')}}"></script>
<script src="{{assetPath('js/bootstrap.min.js','theme')}}"></script>
<script src="{{assetPath('js/custom.min.js','custom')}}"></script>

<script>
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
</script>
</body>

</html>


