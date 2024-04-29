<%-- 
    Document   : index
    Created on : 25 gen 2024, 12:33:40
    Author     : Salvatore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./../assets/css/bootstrap-italia.min.css"/>
    </head>
    <body>

        <header
            class="it-header-wrapper it-header-sticky"
            data-bs-toggle="sticky"
            data-bs-position-type="fixed"
            data-bs-sticky-class-name="is-sticky"
            data-bs-target="#header-nav-wrapper"
            >
            <div class="it-header-slim-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="it-header-slim-wrapper-content">
                                <a class="d-lg-block navbar-brand" href="#"></a>
                                <div class="it-header-slim-right-zone">
                                    <div class="nav-item dropdown">
                                        <div class="dropdown-menu">
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="link-list-wrapper">
                                                        <ul class="link-list">
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="it-nav-wrapper">
                <div class="it-header-center-wrapper">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="it-header-left-content-wrapper">
                                    <div class="it-brand-wrapper">
                                        <a href="">
                                            <svg class="icon" aria-hidden="true">
                                            <use href="/dist/svg/sprites.svg#it-pa"></use>
                                            </svg>
                                            <div class="it-brand-text">
                                                <div class="it-brand-title"><h3 class="kt-login__title kt-font-io" style="font-size:2rem; color:white !important; margin-left: 4rem; "><b>YES I STARTUP - Regione Toscana</b></h3></div>
                                                <!--<div class="it-brand-tagline d-none d-md-block">Uno dei tanti Comuni d'Italia</div>-->
                                            </div>
                                        </a>
                                    </div>
                                    <div class="it-right-zone">
                                        <!--<div class="it-socials d-none d-md-flex">
                                            <span>Seguici su</span>
                                            <ul>
                                                <li>
                                                    <a href="#" aria-label="Facebook" target="_blank">
                                                        <svg class="icon">
                                                        <use href="/dist/svg/sprites.svg#it-facebook"></use>
                                                        </svg>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#" aria-label="Github" target="_blank">
                                                        <svg class="icon">
                                                        <use href="/dist/svg/sprites.svg#it-github"></use>
                                                        </svg>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#" aria-label="Twitter" target="_blank">
                                                        <svg class="icon">
                                                        <use href="/dist/svg/sprites.svg#it-twitter"></use>
                                                        </svg>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>-->
                                        <!--<div class="it-search-wrapper">
                                            <span class="d-none d-md-block">Cerca</span>
                                            <a class="search-link rounded-icon" aria-label="Cerca nel sito" href="#">
                                                <svg class="icon">
                                                <use href="/dist/svg/sprites.svg#it-search"></use>
                                                </svg>
                                            </a>
                                        </div>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="it-header-navbar-wrapper" id="header-nav-wrapper">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <!--start nav-->
                                <nav class="navbar navbar-expand-lg has-megamenu" aria-label="Navigazione principale">
                                    <button
                                        class="custom-navbar-toggler"
                                        type="button"
                                        aria-controls="nav4"
                                        aria-expanded="false"
                                        aria-label="Mostra/Nascondi la navigazione"
                                        data-bs-target="#nav4"
                                        data-bs-toggle="navbarcollapsible"
                                        >
                                        <svg class="icon">
                                        <use href="/dist/svg/sprites.svg#it-burger"></use>
                                        </svg>
                                    </button>
                                    <div class="navbar-collapsable" id="nav4" style="display: none">
                                        <div class="overlay" style="display: none"></div>
                                        <div class="close-div">
                                            <button class="btn close-menu" type="button">
                                                <span class="visually-hidden">Nascondi la navigazione</span>
                                                <svg class="icon">
                                                <use href="/dist/svg/sprites.svg#it-close-big"></use>
                                                </svg>
                                            </button>
                                        </div>
                                        <!--<div class="menu-wrapper">
                                            <ul class="navbar-nav">
                                                <li class="nav-item ">
                                                    <a
                                                        class="nav-link "
                                                        href="/bootstrap-italia/docs/esempi/comuni/template-amministrazione/"
                                                        >
                                                        <span>Amministrazione</span>

                                                    </a>
                                                </li>
                                                <li class="nav-item ">
                                                    <a class="nav-link " href="/bootstrap-italia/docs/esempi/comuni/template-novita/">
                                                        <span>Novità</span>

                                                    </a>
                                                </li>
                                                <li class="nav-item ">
                                                    <a class="nav-link " href="/bootstrap-italia/docs/esempi/comuni/template-servizi/">
                                                        <span>Servizi</span>

                                                    </a>
                                                </li>
                                                <li class="nav-item ">
                                                    <a class="nav-link " href="/bootstrap-italia/docs/esempi/comuni/template-documenti/">
                                                        <span>Documenti e Dati</span>

                                                    </a>
                                                </li>
                                            </ul>
                                            <ul class="navbar-nav navbar-secondary">
                                                <li class="nav-item">
                                                    <a class="nav-link" href="/bootstrap-italia/docs/esempi/comuni/template-argomenti-argomento/"> Argomento 1</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#"> Argomento 2</a>
                                                </li>
                                                <li class="nav-item ">
                                                    <a class="nav-link " href="/bootstrap-italia/docs/esempi/comuni/template-argomenti">
                                                        <span class="fw-bold">Tutti gli argomenti...</span>

                                                    </a>
                                                </li>
                                            </ul>
                                        </div>-->
                                    </div>
                                </nav>
                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </header>

        <div style="background-color: white">
            <br>
            <br>
            <center>
                <img src="assets/soop/img/l2-EU.jpg" alt="" height="60px"/> 
                <img src="assets/soop/img/l3-ML.jpg" alt="" height="60px"/>
                <img src="assets/soop/img/l7-AN.png" alt="" height="60px"/>
                <img src="assets/soop/img/l6-GO.jpg" alt="" height="60px"/>
                <img src="assets/soop/img/l4-RT.jpg" alt="" height="64px"/>
                <img src="assets/soop/img/l1-AR.png" alt="" height="40px"/>
                <img src="assets/soop/img/logo_blue_1.png" alt="" height="64px"/>
            </center>
        </div>

        <script src="/Bootstrap2024/assets/js/bootstrap-italia.min.js"></script>
    </body>
</html>
