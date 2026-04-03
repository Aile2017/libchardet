cmake_minimum_required(VERSION 3.15)
project(chardet VERSION 1.0.7 LANGUAGES CXX)

set(SOURCES
    src/chardet.cpp
    src/CharDistribution.cpp
    src/JpCntx.cpp
    src/tables/LangArabicModel.cpp
    src/tables/LangBulgarianModel.cpp
    src/tables/LangCyrillicModel.cpp
    src/tables/LangDanishModel.cpp
    src/tables/LangEsperantoModel.cpp
    src/tables/LangFrenchModel.cpp
    src/tables/LangGermanModel.cpp
    src/tables/LangGreekModel.cpp
    src/tables/LangHebrewModel.cpp
    src/tables/LangHungarianModel.cpp
    src/tables/LangSpanishModel.cpp
    src/tables/LangThaiModel.cpp
    src/tables/LangTurkishModel.cpp
    src/tables/LangVietnameseModel.cpp
    src/nsBig5Prober.cpp
    src/nsCharSetProber.cpp
    src/nsEscCharsetProber.cpp
    src/nsEscSM.cpp
    src/nsEUCJPProber.cpp
    src/nsEUCKRProber.cpp
    src/nsEUCTWProber.cpp
    src/nsGB2312Prober.cpp
    src/nsHebrewProber.cpp
    src/nsLatin1Prober.cpp
    src/nsMBCSGroupProber.cpp
    src/nsMBCSSM.cpp
    src/nsSBCharSetProber.cpp
    src/nsSBCSGroupProber.cpp
    src/nsSJISProber.cpp
    src/nsUniversalDetector.cpp
    src/nsUTF8Prober.cpp
)

add_library(chardet SHARED ${SOURCES})

target_include_directories(chardet PRIVATE
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/src/tables
)

target_compile_definitions(chardet PRIVATE HAVE_DLL_EXPORT)

# MSVC 固有の設定
if(MSVC)
    # 警告レベルを適切に設定（外部コードなので警告を抑制）
    target_compile_options(chardet PRIVATE /W3 /wd4996 /wd4244 /wd4267)
    # UTF-8 ソースとして扱う
    target_compile_options(chardet PRIVATE /utf-8)
endif()

# インストール設定
install(TARGETS chardet
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)
install(FILES src/chardet.h include/version.h DESTINATION include)
