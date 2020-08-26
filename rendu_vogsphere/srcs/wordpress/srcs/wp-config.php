<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'random' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'zuGpZG0fJ,w*+4a=_%k~t+4NtQ0,IqvF]l#W7^> h7=>C6TnZr_TCO{*0xPG2j4<' );
define( 'SECURE_AUTH_KEY',  '(fWvxP<q!:Q2n?V53]:]at{kMuo=AbU:@R:R<wDS}i@LtKS+nfB6yh~}p@g4k|+8' );
define( 'LOGGED_IN_KEY',    'rY{C[+v$qaOFQ~hi!D$gx59Tz=BLKOlFse|-FVQyfM]?hT$m~+dNcXxYA}G1|FIz' );
define( 'NONCE_KEY',        'br@wAh/s&V2alG53?vqe@rtcP7vlywm`+[?A/$ava6%v&Uve]kegdWkyRLwj?&<,' );
define( 'AUTH_SALT',        '6PdnB1SbpNpdA/go|LYGPI)j6co>y8~j-?)wo]0L0Q?C2_d<S6l(hYYl|0##T.cu' );
define( 'SECURE_AUTH_SALT', 'h}[i]Q^-r!RydZK2RnQXi$f?Q_MJnf]*m u.Eb?(F|RbXkLiCut)@)+_F}vZGigA' );
define( 'LOGGED_IN_SALT',   ',XW_9Ke6c[eV>n^`ho(8x(tTP(0R&B;B?tIvms6Es$59{T}_^LSr)*oHVZ.SpDVA' );
define( 'NONCE_SALT',       'a_@))GBW.!Psd5b:LsM=({2<JA5Whv1q1GA@CAT[fxx{{K4DQN}GZ%}zojgSqlW-' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
